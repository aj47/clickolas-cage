let sharedState = {};

export const getSharedState = async () => {
  return sharedState;
};

export const setSharedState = async (newState) => {
  sharedState = { ...sharedState, ...newState };
};
