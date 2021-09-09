import type { FC } from 'react';
import { VStack, Text } from '@chakra-ui/react';

import { TodoList } from '../components/todolistpagecomponents';

const TodoListPage: FC = () => {
  return (
    <VStack spacing={8}>
      <Text h="1">My Todos</Text>
      <TodoList items={['test', '1', '2', '3']} />
    </VStack>
  );
};

export default TodoListPage;
