var express = require('express')
var router = express.Router()

var politicians = [
	{id: 0, age: 70, firstName:'Donald', lastName:'Trump', positions:[], state:'ny', party:'r'},
	{id: 1, age: 70, firstName:'Hillary', lastName:'Clinton', positions:['senator', 'sec of state'], state:'ny', party:'d'},
	{id: 2, age: 100, firstName:'Bernie', lastName:'Sanders', positions:['senator'], state:'vt', party:'d'},
	{id: 3, age: 55, firstName:'Chris', lastName:'Christie', positions:['governor', 'district attorney'], state:'nj', party:'r'},
	{id: 4, age: 25, firstName:'Marco', lastName:'Rubio', positions:['senator'], state:'fl', party:'d'}
]

router.get('/:resource', function(req, res, next) {
	var resource = req.params.resource

	if (resource == 'politician'){
	    res.json({
	    	confirmation: 'success',
	    	politicians: politicians
	    })

	    return
	}
})

router.get('/:resource/:id', function(req, res, next) {
	var resource = req.params.resource
	var id = req.params.id

	if (resource == 'politician'){
		var politician = politicians[id]

	    res.json({
	    	confirmation: 'success',
	    	politician: politician
	    })

	    return
	}
})

module.exports = router
