"""Todo item component."""

def:pub TodoItem(todo: dict, onToggle: any, onDelete: any) -> any {
    def formatTime(minutes: int) -> str {
        if minutes < 60 {
            return minutes + "m";
        }
        hours = Math.floor(minutes / 60);
        remainingMins = minutes % 60;
        if remainingMins == 0 {
            return hours + "h";
        }
        return hours + "h " + remainingMins + "m";
    }
    
    return
        <div className="todo-item">
            <input
                type="checkbox"
                checked={todo.completed}
                onChange={lambda -> None { onToggle(todo.id); }}
                className="todo-checkbox"
            />
            <span className={("todo-title-completed" if todo.completed else "todo-title")}>
                {todo.title}
            </span>
            {(
                <span className="time-badge">
                    <svg className="time-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                        <circle cx="12" cy="12" r="10"></circle>
                        <polyline points="12 6 12 12 16 14"></polyline>
                    </svg>
                    {formatTime(todo.time_estimate)}
                </span>
            ) if todo.time_estimate else None}
            {(
                <span className="category-badge">{todo.category}</span>
            ) if todo.category and todo.category != "other" else None}
            <button
                onClick={lambda -> None { onDelete(todo.id); }}
                className="todo-delete-btn"
            >
                ×
            </button>
        </div>;
}
