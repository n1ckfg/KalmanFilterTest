//  https://gist.github.com/yoggy/2020928
//  KalmanFilter.pde - Kalman Filter for Processing
//
//  see also:
//    http://www.scipy.org/Cookbook/KalmanFiltering
//
//  example:
//    KalmanFilter kf = new KalmanFilter();
//       .
//       .
//    void draw() {
//        // measurement value
//        float x = getSensorValue();
//
//        // a posteriori estimate of x
//        float xhat = kf.predict_and_correct(x);
//    }

class KalmanFilter {
  float q = 1.0;     // process variance
  float r = 2.0;     // estimate of measurement variance, change to see effect

  float xhat = 0.0;  // a posteriori estimate of x
  float xhatminus;   // a priori estimate of x
  float p = 1.0;     // a posteriori error estimate
  float pminus;      // a priori error estimate
  float kG = 0.0;    // kalman gain
  
  KalmanFilter() {};
  KalmanFilter(float q, float r) {
    q(q); 
    r(r);
  }
  
  void q(float q) {
    this.q = q;
  }
  
  void r(float r) {
    this.r = r;
  }
  
  float xhat() {
    return this.xhat;
  }

  void predict() {
    xhatminus = xhat;
    pminus = p + q;
  }

  float correct(float x) {
    kG = pminus / (pminus + r);
    xhat = xhatminus + kG * (x - xhatminus);
    p = (1 - kG) * pminus;
    
    return xhat;
  }
  
  float predict_and_correct(float x) {
    predict();
    return correct(x);
  }
  
}