use Test::More;

# struct MockBehavior : public Behavior
# {
#     int m_iInitializeCalled;
#     int m_iTerminateCalled;
#     int m_iUpdateCalled;
#     Status m_eReturnStatus;
#     Status m_eTerminateStatus;

#     MockBehavior()
#     :	m_iInitializeCalled(0)
#     ,	m_iTerminateCalled(0)
#     ,	m_iUpdateCalled(0)
#     ,	m_eReturnStatus(BH_RUNNING)
#     ,	m_eTerminateStatus(BH_INVALID)
#     {
#     }

#     virtual ~MockBehavior()
#     {
#     }

#     virtual void onInitialize()
#     {
#         ++m_iInitializeCalled;
#     }

#     virtual void onTerminate(Status s)
#     {
#         ++m_iTerminateCalled;
#         m_eTerminateStatus = s;
#     }
    
#     virtual Status update()
#     {
#         ++m_iUpdateCalled;
#         return m_eReturnStatus;
#     }
# };


# TEST(StarterKit1, TaskInitialize)
# {
#     MockBehavior t;
#     CHECK_EQUAL(0, t.m_iInitializeCalled);

#     t.tick();
#     CHECK_EQUAL(1, t.m_iInitializeCalled);
# };

# TEST(StarterKit1, TaskUpdate)
# {
#     MockBehavior t;
#     CHECK_EQUAL(0, t.m_iUpdateCalled);

#     t.tick();
#     CHECK_EQUAL(1, t.m_iUpdateCalled);
# };

# TEST(StarterKit1, TaskTerminate)
# {
#     MockBehavior t;
#     t.tick();
#     CHECK_EQUAL(0, t.m_iTerminateCalled);

#     t.m_eReturnStatus = BH_SUCCESS;
#     t.tick();
#     CHECK_EQUAL(1, t.m_iTerminateCalled);
# };
