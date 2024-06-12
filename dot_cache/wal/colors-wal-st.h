const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#020406", /* black   */
  [1] = "#284F76", /* red     */
  [2] = "#525F61", /* green   */
  [3] = "#8A796B", /* yellow  */
  [4] = "#305988", /* blue    */
  [5] = "#196497", /* magenta */
  [6] = "#2961AB", /* cyan    */
  [7] = "#bfc0c0", /* white   */

  /* 8 bright colors */
  [8]  = "#414244",  /* black   */
  [9]  = "#284F76",  /* red     */
  [10] = "#525F61", /* green   */
  [11] = "#8A796B", /* yellow  */
  [12] = "#305988", /* blue    */
  [13] = "#196497", /* magenta */
  [14] = "#2961AB", /* cyan    */
  [15] = "#bfc0c0", /* white   */

  /* special colors */
  [256] = "#020406", /* background */
  [257] = "#bfc0c0", /* foreground */
  [258] = "#bfc0c0",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
