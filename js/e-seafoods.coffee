---
---
angular.module 'eSeafoodsApp', ['ngCookies', 'ngCart', 'mgcrea.ngStrap', 'ngSanitize'], ($interpolateProvider) ->
  $interpolateProvider.startSymbol '[['
  $interpolateProvider.endSymbol ']]'
.filter 'joinBy', ->
  (input, delimiter) ->
    (input or []).join delimiter or ','
.directive 'mixItUpAfterRender', [
  '$timeout'
  ($timeout) ->
    {
      restrict: 'A'
      link: (scope, element, attrs) ->
        $timeout scope.refreshMixItUp, 0
        #Calling a scoped method
        return
    }
]
.directive 'relatedProducts', [
  '$timeout'
  ($timeout) ->
    {
    restrict: 'A'
    link: (scope, element, attrs) ->
      esf.autoPlaySlider.play()
      esf.autoPlaySlider.refresh()
      return
    }
]
.filter 'capitalize', ->
  (input) ->
    input.charAt(0).toUpperCase() + input.substr(1).toLowerCase()

.controller 'StoreCtrl',
  ($scope, $http, $log, $cookies) ->

    SPLASH_COOKIE_NAME = '_splash'
    $scope.splashed = $cookies.get(SPLASH_COOKIE_NAME)
    $cookies.put(SPLASH_COOKIE_NAME, new Date().getTime())

    $scope.refreshMixItUp = ->
      $('#products').mixItUp('filter', 'all')

    $http.get('/api/products.json').success (data) ->
      $scope.products = data
      for product in $scope.products
        product.lowestPrice = _.min(_.map(product.types, (type) ->
          _.min _.map(type.sizes, (size) ->
            size.price
          )
        ))
#        $log.debug product
      $ ->
#        $log.debug "INIT MIXITUP"
        $('#products').mixItUp
          load: filter: 'all'

.controller 'PickOptionsCtrl',
  ($scope, $log) ->
    $scope.data = {}
    $scope.product =
    $scope.data.selectedType
    $scope.data.selectedSize
    $scope.data.kg = 1

    $scope.setProduct = (data) ->
      $log.debug 'Initializing product data'
      $scope.product = data

    $scope.setSelectedType = (type) ->
      $log.debug 'Initializing selected type'
      $scope.data.selectedType = type

    $scope.setSelectedSize = (size) ->
      $log.debug 'Initializing selected size'
      $log.debug size
      $scope.data.selectedSize = size

    $scope.calculateTotal = ->
      $total = 0
      if(!angular.isUndefined($scope.data.selectedSize))
        $total = $scope.data.selectedSize.price * $scope.data.kg

      return $total
