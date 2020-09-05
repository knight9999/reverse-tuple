# What is this?

A sample for creating a class `Reverse` that reverses the type of a tuple.

## Example: Reverse the order of tuples `(Int, String, Number)`.

In PureScript, a tuple `(Int, String, Number)` is of the type `Int /\ String /\ Number /\ Unit` using `Data.Tuple.Nested`.

The following is a type constraint of the type class `Reverse` that reverses this type.

```
forall m. Reverse (Int /\ String /\ Number /\ Unit) m =>
```

A proxy for tuples, `TProxy`, which is the same as `Proxy` but is an instance of `show`, gives you the following.

```
  log $ show (TProxy :: forall m. (Reverse (Int /\ String /\ Number /\ Unit) m) => TProxy m)
```

Result

```
(Number,String,Int)
```

# How to use?

## Build

```
% npm install
% npm run build 
```

## Run

```
% npm start
```

## Test

```
% npm test
```



