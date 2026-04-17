export default function useNavigation() {
  const goTo = (router, routeName, params = {}) => {
    if (router && routeName) {
      router.push({ name: routeName, params })
    }
  }
  return { goTo }
}
