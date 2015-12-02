shared void run() {
    print("Printing an example HTML table:");
    
    alias Name => String;
    alias Weight => Integer;
    alias Height => Float;
    
    [[Name, Weight, Height]+] data = [
        ["John", 72, 1.79],
        ["Mary", 61, 1.76],
        ["Ana", 77, 1.89]
    ];
    
    value stringData = data.map((row)
        => [row[0].string, row[1].string, row[2].string]);
    
    render(process.write, 
        header(["Name", "Weight", "Height"]), 
        stringData.map(row));

}