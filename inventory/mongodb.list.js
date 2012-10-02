/***************************
 *
 * This is a MongoDB script file intended to be used 
 * as part of the MongoDB invetory plug-in.
 * Please see mongodb.sh for instructions
 */
var result = {};
for(coll in config) {
    result[coll] = db[coll].find().map(function(x){ return x[config[coll]]; });
}
printjson(result);
