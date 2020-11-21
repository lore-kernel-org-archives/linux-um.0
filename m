Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgPPE-0000op-Vc
 for linux-um@lists.infradead.org; Sat, 21 Nov 2020 09:42:11 +0000
Message-ID: <f24b6ab92e4a6c06fa36d94551eb42b686cf73db.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] um: allow PM with suspend-to-idle
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sat, 21 Nov 2020 10:42:03 +0100
In-Reply-To: <ddd00c01-55a0-00ea-60cc-3a710207befd@kot-begemot.co.uk>
References: <20201120212921.880781-1-johannes@sipsolutions.net>
 <20201120222625.7a475c89cdd4.Id4fe7fb6f0405eb24f3db3ae7a6276293f0ce6f7@changeid>
 <9731397936ba99253548843d9e487ce0df44bdce.camel@sipsolutions.net>
 <ddd00c01-55a0-00ea-60cc-3a710207befd@kot-begemot.co.uk>
MIME-Version: 1.0
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org

On Sat, 2020-11-21 at 09:34 +0000, Anton Ivanov wrote:
> On 20/11/2020 21:33, Johannes Berg wrote:
> > On Fri, 2020-11-20 at 22:29 +0100, Johannes Berg wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > > 
> > > In order to be able to experiment with suspend in UML,
> > > add the minimal work to be able to suspend (s2idle) an
> > > instance of UML, and be able to wake it back up from
> > > that state with the USR1 signal sent to the main UML
> > > process.
> > 
> > So what I said about rtcwake ... maybe that's an argument for removing
> > the USR1 handling? I wasn't really too sure about it.
> > 
> > But on the other hand, typically real systems will have at least *some*
> > kind of wakeup source that you can manually use and that's always
> > enabled, perhaps the power button for example; the SIGUSR1 handling was
> > meant to simulate such a thing.
> 
> This usually translates to the IRQ controller being powered on even if 
> the rest of the machine is off and some lines being able to function 
> even in power down state.
> 
> Not that difficult actually. Going to sleep should just turn off all 
> relevant IRQs including de-registering fds. If you are not 
> de-registering the fds, the fact that it is turned off in the controller 
> will be of no use - it will be re-triggered.

Right. Now I have only s2idle where of course all this machinery is
still enabled, even if you had a real (say x86) system s2idle would
obviously not turn off any hardware.

> Waking up should restore the state.
> 
> Once that is in place, you can emulate the full PM sleep/wake up cycle.

Indeed. I'll continue work later. This was a one-day hack so far :-)

> Emulating suspend to disk is more interesting. I actually looked at it 
> many years ago and that looked nearly impossible to implement.

Hmmmm... That's going to be very tricky, if not impossible, due to you
being a new process when restoring, and then memory layout may differ, I
think?

Not a use case I care about for UML, TBH, though I did implement suspend
to disk for powerpc many years ago :-)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

