Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 25 May 2021 09:08:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] LOCKDEP: reduce LOCKDEP dependency list
Message-ID: <YKyiZBAGcbGMEjTc@hirez.programming.kicks-ass.net>
References: <20210524224150.8009-1-rdunlap@infradead.org>
 <3398848.TK9RqziN78@ubuntu-mate-laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3398848.TK9RqziN78@ubuntu-mate-laptop>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Julian Braha <julianbraha@gmail.com>
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Johannes Berg <johannes@sipsolutions.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, linux-arch@vger.kernel.org

On Mon, May 24, 2021 at 11:31:22PM -0400, Julian Braha wrote:
> Hi Randy,
> 
> It seems I introduced a new unmet dependency bug
> in my attempt to fix one :/
> 
> Anyway, I don't see why the dependency on FRAME_POINTER
> was necessary in the first place, so LGTM.

It might have been an attempt at ensuring sane backtraces; but I didn't
dig into the history of the thing. Either way around, it's fairly
out-dated if that was indeed the case.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

