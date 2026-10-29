import base from '@linzjs/style/oxfmt.config';

export default {
  ...base,
  ignorePatterns: [...base.ignorePatterns, 'publish-odr-parameters/'],
};
