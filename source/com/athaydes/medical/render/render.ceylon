import ceylon.html {
    Html,
    html5,
    Head,
    Body,
    H1,
    Table,
    Th,
    Tr,
    Td
}

shared class InvariantTuple<Element, First, Rest = []>(
    shared Tuple<Element, First, Rest> tuple) {}

shared InvariantTuple<Element, First, Rest> header<Element, First, Rest = []>(
    Tuple<Element, First, Rest> tuple)
    => InvariantTuple(tuple);

shared InvariantTuple<Element, First, Rest> row<Element, First, Rest = []>(
    Tuple<Element, First, Rest> tuple)
        => InvariantTuple(tuple);

shared void render<Element, First, Rest>(
    Anything(String) write,
    InvariantTuple<Element, First, Rest> headers,
    {InvariantTuple<Element, First, Rest>+} cells) {
    
    function asString(Anything item)
        => item?.string else "?";
    
    Html html = Html {
        doctype = html5;
        Head {
            title = "Medical Web";
        };
        Body {
            H1("Medical Web App"),
            Table {
                header = headers.tuple.map(asString).map(Th);
                rows = cells.map((row) => Tr {
                    row.tuple.map(asString).map(Td)
                });
            }
        };
    };
    
    write(html.string);
}
