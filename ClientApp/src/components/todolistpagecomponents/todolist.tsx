import type { FC } from 'react';

import TodoItem from './todoitem';

export interface TodoListProps {
  items: string[];
}

const TodoList: FC<TodoListProps> = ({ items }) => {
  return (
    <>
      {items.map((item) => (
        <TodoItem>{item}</TodoItem>
      ))}
    </>
  );
};

export default TodoList;
