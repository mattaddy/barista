## Barista Example

A project that demonstrates the use of a library that was developed from a real world problem - how can we write maintainable JavaScript without using an MVC framework? In typical Rails applications, the view layer is handled by the server. This solution uses a "component" or "module" system that allows us to instantiate any number of components for a specific page. A component is simply an area of the view that a chunk of JavaScript code is responsible for handling. A component is responsible for handling and responding to events *from within the element the component is configured with.** See the section titled "Event Aggregator" for how to publish and bind to events from other components.

#### Running the example

```
git clone this repository
bundle install
rails s
```

Navigate to `http://localhost:3000`.

#### Getting Started

To get started, we include `barista.js` into the project and instantiate a new `Barista.Application` object after the document is loaded.

```
window.App = new Barista.Application()
```

Now we can define which components should be instantiated on a controller/action basis by attaching a `routes` object to `App`.

```
App.routes
  app: ->
    new Header(el: '#header')

  pages:
    one: ->
      new Sidebar(el: '#sidebar')
```

In the above example, when our `Pages#one` action renders its view to the client, Barista will instantiate a new Sidebar component which is responsible for handling the portion of the page inside an element with id `sidebar`.

Any components instantiated from the `app` function of the routes object will be instantiated on *every* page.

#### Components

To define a component, we create a CoffeeScript class that extends from `Barista.Component.`

```
class @Header extends @Barista.Component
```

Inside our component, we can define an `events` object, which allows us to bind to events that are triggered from an element within the component.

```
events:
  'click #clickable': 'increment_clicks'
```

The above example will call the `increment_clicks` function from within the component when the element with id `clickable` is clicked. **Note** that the element with id `clickable` must be a child of the element the component is responsible for.

#### Event Aggregator

Oftem times two components need to communicate with each other. For example, we might have a component that is responsible for handling the draggable area of a drag-and-drop, while another component handles the droppable area. To do this, we can `trigger` and `bind` to events by using the `App.vent` object.

```
App.vent.bind 'someEvent', @myHandlingFunction

myHandlingFunction: (e, data) ->
  # We have access to data if the component that published the event sent it along...
```

If another component triggers this event, the function `myHandlingFunction` will be called on the component. To trigger the event, call `trigger.`

```
App.vent.trigger 'someEvent', data
```

Notice in the above example we're sending `data` along with the trigger call, so any event handlers that register to this event will get this data as an argument to the function.

Under the hood, the `App.vent` object implements a simple event aggregator which is a basic abstraction on top of jQuery's native `bind` and `trigger` functions.
