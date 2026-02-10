**Name:** Shiva Chandran  
**UMID:** 12247092

## Project Description

TaskFlow is a multi-user todo application built with Jac that combines task management with AI-powered meal planning. This application features intelligent task categorization, shopping list generation, and **AI-powered time estimation** for tasks.

### Feature Added: AI-Powered Task Time Estimation

This feature automatically estimates how long each task will take using AI. When users add a new todo item, the system analyzes the task description and provides an intelligent time estimate (ranging from 5 minutes to 8 hours). The application displays:

- Individual time estimates on each task (shown as badges like "45m", "2h", or "2h 30m")
- Total estimated time for all incomplete tasks
- Visual clock icons to make time information easily scannable

## Installation Instructions

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd my-todo-app
   ```

2. **Install dependencies**
   ```bash
   pip install jaseci
   ```

3. **Run the application**
   ```bash
   jac start main.jac
   ```

4. **Access the application**
   Open your browser and navigate to `http://localhost:8000`

## How the Time Estimation Feature Works

The time estimation feature is implemented across multiple files:

#### 1. **Backend AI Integration** (`main.jac`)
   - **Location:** Lines 32-33
   - **Function:** `estimate_duration(task_title: str) -> int by llm()`
   - **Description:** Uses the Gemini LLM to analyze task descriptions and return time estimates in minutes
   - **Bounds:** Ensures estimates stay between 5-480 minutes (validated in AddTodo walker)

#### 2. **Data Model** (`main.jac`)
   - **Location:** Lines 43-49
   - **Node:** `Todo` node now includes `time_estimate: int = 30` field
   - **Description:** Stores the estimated duration for each task

#### 3. **Task Creation** (`main.jac`)
   - **Location:** Lines 58-80 (AddTodo walker)
   - **Process:**
     1. User submits a task title
     2. AI categorizes the task
     3. AI estimates the duration
     4. Duration is validated (5-480 min range)
     5. Task is created with the estimate

#### 4. **Frontend Display** (`frontend.jac`)
   - **Location:** Lines 71-72, 137-152
   - **Components:**
     - Individual task time badges (via TodoItem component)
     - Aggregate time display in task summary section
   - **Features:**
     - Shows total estimated time for incomplete tasks only
     - Displays with clock icon for visual clarity

#### 5. **Time Formatting Logic** (`frontend.impl.jac`)
   - **Location:** Lines 123-133
   - **Functions:**
     - `getTotalEstimatedTime()`: Sums up time for all incomplete tasks
     - `formatTimeEstimate()`: Converts minutes to readable format (e.g., "2 hr 30 min")

#### 6. **UI Components** (`components/TodoItem.jac`)
   - **Location:** Lines 4-14, 28-35
   - **Features:**
     - Purple time badge with clock icon
     - Smart formatting: "45m" for <1hr, "2h" or "2h 30m" for longer durations
     - Conditional display (only shows if time_estimate exists)
