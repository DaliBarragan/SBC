(deffacts initial-state
    (location monkey floor)
    (location bananas ceiling)
    (location box floor)
    (position monkey door)
    (position box window)
    (position bananas center)
    (monkey-state on-floor)
)

(defrule move-to-box
    (location monkey floor)
    (position monkey ?mpos)
    (position box ?boxpos)
    (test (neq ?mpos ?boxpos))
    =>
    (retract (position monkey ?mpos))
    (assert (position monkey ?boxpos))
    (printout t "The monkey moves to the box." crlf)
)

(defrule push-box-to-bananas
    (location monkey floor)
    (position monkey ?boxpos)
    (position box ?boxpos)
    (position bananas ?bananapos)
    (test (neq ?boxpos ?bananapos))
    =>
    (retract (position box ?boxpos))
    (assert (position box ?bananapos))
    (retract (position monkey ?boxpos))
    (assert (position monkey ?bananapos))
    (printout t "The monkey pushes the box to the bananas." crlf)
)

(defrule climb-box
    (location monkey floor)
    (position monkey ?boxpos)
    (position box ?boxpos)
    =>
    (retract (location monkey floor))
    (assert (location monkey box))
    (retract (monkey-state on-floor))
    (assert (monkey-state on-box))
    (printout t "The monkey climbs the box." crlf)
)

(defrule grab-bananas
    (location monkey box)
    (position box ?bananapos)
    (position bananas ?bananapos)
    =>
    (assert (monkey-has bananas))
    (printout t "The monkey grabs the bananas." crlf)
)

(defrule goal-achieved
    (monkey-has bananas)
    =>
    (printout t "The monkey has achieved the goal and has the bananas!" crlf)
)

(reset)
(run)
