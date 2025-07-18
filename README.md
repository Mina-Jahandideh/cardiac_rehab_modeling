
> ⚠️ Due to ethical and privacy considerations, the dataset (`data3.sav`) is not publicly available.

---

## 🛠️ Tools and Libraries Used

| Library      | Purpose                                      |
|--------------|----------------------------------------------|
| `haven`      | Importing SPSS `.sav` files                  |
| `MASS`       | Base for ordinal regression, statistics      |
| `fixedpolr`  | Custom extension for `polr()` function       |

---

## 🔍 Workflow Summary

1. **Data Preparation**
   - SPSS data is imported using `haven::read_sav`.
   - Selected variables are converted to factors (some ordered).
  
2. **Variable Selection**
   - Six sets of 10 predictors are manually defined for six `intention.item.x` targets.

3. **Modeling Loop**
   - For each target variable:
     - A formula is dynamically generated.
     - `fixedpolr()` fits the model.
     - Odds ratios, confidence intervals, and p-values are calculated.
     - Significant results (`p < 0.05`) are extracted and saved.

4. **Results Storage**
   - Results are stored in two lists:
     - `significantrows` — variables with p < 0.05
     - `allrows` — all variables with OR and CIs

---

## 💡 What is `fixedpolr.R`?

A custom R script that modifies or extends the base `polr()` function from the `MASS` package to handle more robust modeling and diagnostics. This function is sourced at the beginning of the script.

---

## 📌 Requirements

- R 4.0+
- Packages:
  - `haven`
  - `MASS`
  - Source file: `fixedpolr.R`

---

## 📁 Data Privacy

The SPSS dataset (`data3.sav`) contains sensitive health data and is **not shared publicly**. You can test the script by substituting your own dataset with a similar structure.

---

## 📬 Contact

**Author**: Mina Jahandideh  
**Email**: mn.jahandideh@gmail.com  
**GitHub**: [@Mina-Jahandideh](https://github.com/Mina-Jahandideh)

---

## 📄 License

This code is shared under the MIT License. Please give appropriate credit if used in academic or applied work.
