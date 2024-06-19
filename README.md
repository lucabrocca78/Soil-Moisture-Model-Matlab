# Soil Moisture Model in Matlab
Soil water balance model for estimating soil moisture

The model can be freely applied and used, just cite some of the references to the model reported below.
The authors are highly interested to collaborate for the understanding of the model functioning and to improve its performance and applicability.

For any questions please do not hesitate to contact:
luca.brocca@irpi.cnr.it

-------------------------------------------

For running the model with the example data just type:
run_SMmodel.m

The first part is for parameter values calibration, the second for simply running the model.

"SMestim_IE_02.m": Soil Moisture Model

"cal_SMestim_IE_02.m": Function for calibrating the model (requires optimization toolbox)

"data.txt": Data for the example (date, precipitation [mm], air temperature [°C] and relative soil moisture [% saturation])

"IEmodel_example.png": Figure with the model results

"Xopt.txt": Optimal set of parameter values for the selected data in the example

(a Python version is also available: https://github.com/lucabrocca78/Soil-Moisture-Model-Python)

# Main Reference for the model:
Brocca, L., Melone, F., Moramarco, T. (2008). On the estimation of antecedent wetness conditions in rainfall-runoff modelling. Hydrological Processes, 22 (5), 629-642, doi:10.1002/hyp.6629. http://dx.doi.org/10.1002/hyp.6629
Brocca, L., Camici, S., Melone, F., Moramarco, T., Martinez-Fernandez, J., Didon-Lescot, J.-F., Morbidelli, R. (2014). Improving the representation of soil moisture by using a semi-analytical infiltration model. Hydrological Processes, 28(4), 2103-2115, doi:10.1002/hyp.9766. http://dx.doi.org/10.1002/hyp.9766
