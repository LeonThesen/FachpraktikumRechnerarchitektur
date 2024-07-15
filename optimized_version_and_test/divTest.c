int main() {
    int smallestNum = -511;
    int biggestNum = 511;

    for(int dividend = smallestNum; dividend <= biggestNum; dividend++) {
        for(int divisor = smallestNum; divisor <= biggestNum; divisor++) {
            int quotient = dividend / divisor;
        }
    }
}