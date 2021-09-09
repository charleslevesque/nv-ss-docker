import type { FC } from 'react';
import { Text } from '@chakra-ui/react';

const TodoItem: FC = ({ children }) => {
  return <Text>{children}</Text>;
};

export default TodoItem;
