# react-cli
Generate react components from the command line

## Installation
Copy code to your .zshrc file

## Usage
![](react-cli-demo.gif)

Generate either functional [-f] or class [-c] components in react.

By default the component is created in the components directory. You can optionally change the path.  

#### Class Component Example

```sh
$ cd my-react-app
$ component my-component -c [optional:path]
```

**Folder structure within src:**  
components/my-component/my-component.jsx    
components/my-component/my-component.scss

**Boilerplate code:**  
*NB: Hypened component class names are converted to PascalCase*
        
```sh
import React from 'react';
import './my-component.scss';

class MyComponent extends React.Component {
	constructor() {
		super();
		this.state = {}
	}

	render() {
		return (
		    <div className='my-component'>

		    </div>)
	}
}

export default MyComponent;
```

