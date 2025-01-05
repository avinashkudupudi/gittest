public class OppWrapper {
        public Opportunity opp { get; set; }
    public Integer tabIndex { get; set; }
public OppWrapper(Opportunity opp, Integer tabIndex) {
    this.opp = opp;
    this.tabIndex = tabIndex;
} 
}