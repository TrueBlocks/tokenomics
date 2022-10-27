package cmd

import (
	"tb-accounting/internal/statements"

	"github.com/spf13/cobra"
)

var statementsCmd = &cobra.Command{
	Use:   "statements",
	Short: "Summarize previously generated statements",
	Long:  `Summarize previously generated statements.`,
	Run:   statements.RunStatements,
}

func init() {
	rootCmd.AddCommand(statementsCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// statementsCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// statementsCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
