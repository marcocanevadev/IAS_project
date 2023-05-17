        %---- Perform KNN Classification on three Groups of features ----

        %---- Divide in Three Groups ----
group_a_timeTR = allfeaturesNorm(:,19:21);
group_b_freqTR = allfeaturesNorm(:,1:18);
group_c_allTR = allfeaturesNorm;

group_a_timeTE = allfeaturesTestNorm(:,19:21);
group_b_freqTE = allfeaturesTestNorm(:,1:18);
group_c_allTE = allfeaturesTestNorm;

