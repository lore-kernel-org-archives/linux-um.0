Return-Path: <linux-arch-owner@vger.kernel.org>
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v2] LOCKDEP: reduce LOCKDEP dependency list
Date: Mon, 24 May 2021 23:31:22 -0400
Message-ID: <3398848.TK9RqziN78@ubuntu-mate-laptop>
In-Reply-To: <20210524224150.8009-1-rdunlap@infradead.org>
References: <20210524224150.8009-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Johannes Berg <johannes@sipsolutions.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

Hi Randy,

It seems I introduced a new unmet dependency bug
in my attempt to fix one :/

Anyway, I don't see why the dependency on FRAME_POINTER
was necessary in the first place, so LGTM.

- Julian Braha



