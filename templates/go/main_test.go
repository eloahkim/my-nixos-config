package main

import "testing"

func TestSoma(t *testing.T) {
	if got := soma(2, 3); got != 5 {
		t.Fatalf("soma(2, 3) = %d; quer 5", got)
	}
}
