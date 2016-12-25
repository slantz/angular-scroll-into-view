# stz-scroll-into-view

[![stz-scroll-into-view on NPM](https://img.shields.io/npm/v/stz-scroll-into-view.svg)](https://www.npmjs.com/package/stz-scroll-into-view)
[![stz-scroll-into-view on Bower](https://img.shields.io/bower/v/stz-scroll-into-view.svg)](http://bower.io/search/?q=stz-scroll-into-view)

> This directive allows to scroll to a custom Node list array element inside a parent container.

> Can be used along with stz-image-load directive if all of the child elements are images or contain images to scroll to a particular element only when all images are loaded or with stz-last-repeat directive to consider the ng-repeat presence and scroll after ng-repeat is rendered. Or can make use of both ng-repeat and images combined.

> IE9+.

[Demo](http://slantz.github.io/angular-scroll-into-view/)

### Static List Example:
> By default the list view will be scrolled to the element that has ```[stz-s-i-v-ele="true"]```attribute.

```html
<ul stz-scroll-into-view>
  <li stz-s-i-v-ele="false">Hidden</li>
  <li stz-s-i-v-ele="not-to-me">Hidden</li>
  <li stz-s-i-v-ele="let-me-think...no">Hidden</li>
  <li stz-s-i-v-ele="true">Visible</li>
  <li stz-s-i-v-ele="scroll-to-the-guy-above-me">Maybe visible, too.</li>
</ul>
```

### Static List Example With Watcher:
> where ```isTimeToScrollScopeVar``` will be resolved to ```'scroll-to-me'```.

```html
<ul stz-scroll-into-view="isTimeToScrollScopeVar">
  <li stz-s-i-v-ele="false">Hidden</li>
  <li stz-s-i-v-ele="false">Hidden</li>
  <li stz-s-i-v-ele="scroll-to-me">Hidden</li>
  <li stz-s-i-v-ele="false">Hidden</li>
  <li stz-s-i-v-ele="false">Hidden</li>
</ul>
```

### Static List Example With Images:
```html
<div stz-scroll-into-view stz-s-i-v-img>
  <img src="placehold.it/800x600/8A8BA6/CACBF2/" stz-s-i-v-ele="false" stz-image-load alt="I think I deserve to be scrolled to!"/>
  <img src="placehold.it/800x620/8A8BA6/CACBF2/" stz-s-i-v-ele="true" stz-image-load alt="I think I deserve to be scrolled to!"/>
  <img src="placehold.it/800x640/8A8BA6/CACBF2/" stz-s-i-v-ele="false" stz-image-load alt="I think I deserve to be scrolled to!"/>
  <img src="placehold.it/800x660/8A8BA6/CACBF2/" stz-s-i-v-ele="no" stz-image-load alt="I think I deserve to be scrolled to!"/>
  <img src="placehold.it/800x680/8A8BA6/CACBF2/" stz-s-i-v-ele stz-image-load alt="I think I deserve to be scrolled to!"/>
</div>
```

### Static List Example With Extra Parent that should be scrolled to top:
> ```stz-scroll-into-view``` element is used by default.

```html
<section id="content">
  <h1>The most amazing title ever!!!</h1>
  <ul stz-scroll-into-view stz-s-i-v-parent-id="content">
    <li stz-s-i-v-ele="0">Maybe visible, too.</li>
    <li stz-s-i-v-ele="false">Maybe noticable, too.</li>
    <li stz-s-i-v-ele="no-scroll-for-me">Maybe valuable, too.</li>
    <li stz-s-i-v-ele="true">Maybe managable, too.</li>
    <li stz-s-i-v-ele="scroll-to-the-guy-above-me">Maybe available, too.</li>
  </ul>
</section>
```

### Dynamic List Example:
> where ```scroll.isActive``` is expected to be ```true```.

```html
<ul stz-scroll-into-view stz-s-i-v-ng-repeat>
  <li ng-repeat="scroll in scrollSuperCollection" stz-s-i-v-ele="{{scroll.isActive}}" stz-last-repeat>{{scroll.title}}</li>
</ul>
```

### Dynamic List Example With Watcher:
> where ```scrollAwesomeIndex``` can be watched to be defined or any other scope param can be passed.
Let it be resolved to say 7 here and scrollAwesomeList will have 10 elements.

```html
<ul stz-scroll-into-view="scrollAwesomeIndex" stz-s-i-v-ng-repeat>
  <li ng-repeat="scroll in scrollAwesomeList track by $index" stz-s-i-v-ele="{{$index}}" stz-last-repeat>{{scroll.title}}</li>
</ul>
```

### Dynamic List Example With Images:
> where ```scroll.isActive``` is expected to be ```true```.

```html
<ul stz-scroll-into-view stz-s-i-v-ng-repeat stz-s-i-v-img>
  <li ng-repeat="scroll in scrollAwesomeList track by $index" stz-s-i-v-ele="{{scroll.isActive}}" stz-last-repeat>
    <img ng-src="placehold.it/8{{$index % 5}}0x6{{$index % 10}}0/8A8BA6/CACBF2/" stz-image-load alt="I think I deserve to be scrolled to!"/>
  </li>
</ul>
```

### Dynamic List Example With Images and Watcher:
> where ```scrollAwesomeIndex``` can be watched to be defined or any other scope param can be passed.
Let it be resolved to say 7 here and scrollAwesomeList will have 10 elements.
The scroll will happen only when ng-repeat is rendered, all images are loaded and ```scrollAwesomeIndex``` is resolved.

```html
<ul stz-scroll-into-view="scrollAwesomeIndex" stz-s-i-v-ng-repeat stz-s-i-v-img>
  <li ng-repeat="scroll in scrollAwesomeList track by $index" stz-s-i-v-ele="{{$index}}" stz-last-repeat>
    <img ng-src="placehold.it/8{{$index % 5}}0x6{{$index % 10}}0/8A8BA6/CACBF2/" stz-image-load alt="I think I deserve to be scrolled to!"/>
  </li>
</ul>
```
