# Submission checklist

Run before a deliverable leaves draft.

## Reproducibility
- [ ] `make DOCKER=1 all` builds every PDF from a clean checkout.
- [ ] Every figure is regenerable from source.
- [ ] Every reported number names the run, script or data it came from.

## Disclosure
- [ ] If an agentic pipeline drafted or reviewed the text, say so and say how
      human judgement adjudicated.
- [ ] No private data in text, bibliography, figures, or git metadata (commit
      messages, branch names, PR titles and bodies).
- [ ] Prior-art attribution is fair and exact; licences of reused material are
      respected and cited.

## Camera-ready
- [ ] Editorial markers silenced (see `common/macros.sty`).
- [ ] Class options switched from draft to the venue's format.
- [ ] Front matter complete: authors, affiliation, CCS concepts, keywords.
