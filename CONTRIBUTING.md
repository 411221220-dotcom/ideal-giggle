# Contributing to Stargazing Social

Thank you for your interest in contributing to the Stargazing Social Community app!

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/ideal-giggle.git`
3. Create a feature branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Run tests: `flutter test`
6. Run linter: `flutter analyze`
7. Commit your changes: `git commit -m "Add your feature"`
8. Push to your fork: `git push origin feature/your-feature-name`
9. Open a Pull Request

## Code Style

- Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use the provided `analysis_options.yaml` for linting
- Run `flutter format .` before committing
- Maintain consistent naming conventions

## Project Structure

- `lib/app/` - App configuration and routing
- `lib/core/` - Core utilities, constants, themes, services
- `lib/data/` - Data models, repositories, providers
- `lib/features/` - Feature modules (auth, feed, events, etc.)
- `lib/shared/` - Shared widgets and extensions

## Feature Development

When adding a new feature:

1. Create the feature directory under `lib/features/`
2. Implement BLoC for state management
3. Create screens and widgets
4. Add routes to `lib/app/routes.dart`
5. Update README if needed
6. Write tests

## Testing

- Write unit tests for business logic
- Write widget tests for UI components
- Write integration tests for critical flows
- Maintain test coverage above 70%

## Pull Request Guidelines

- Keep PRs focused on a single feature or fix
- Write clear, descriptive commit messages
- Include screenshots for UI changes
- Update documentation as needed
- Ensure all tests pass
- Address review feedback promptly

## Code Review Process

1. Automated checks must pass (linting, tests)
2. At least one maintainer approval required
3. All conversations must be resolved
4. Squash and merge to main branch

## Questions?

Feel free to open an issue for any questions or discussions!
