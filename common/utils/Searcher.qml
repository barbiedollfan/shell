pragma Singleton
import Quickshell
import "fuzzysort.js" as FuzzySort

Singleton {
    function query(search: string, targets: var, options: var): var {
        return FuzzySort.go(search, targets, options).sort((a, b) => b.score - a.score).map((result) => result.obj);
    }
}
