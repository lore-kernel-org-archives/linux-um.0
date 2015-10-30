Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <1446186594.2098205.424343233.1586EFFB@webmail.messagingengine.com>
References: <1446118127.337460.423488209.12F26E25@webmail.messagingengine.com>
	<CAFLxGvzo2Yw_yYxDOWJJB09OHWM02ex5ivbK2=uV8Xppx53trg@mail.gmail.com>
	<1446124492.1062111.423580545.6ECCD145@webmail.messagingengine.com>
	<56321C94.7090702@nod.at>
	<1446124893.1063455.423585953.2F3C49FD@webmail.messagingengine.com>
	<CAFLxGvyXud1Nujy3M-xB564B2FM_1AfaEWEpJP3ei1WTnpoRSg@mail.gmail.com>
	<1446132374.1089982.423700145.2CC8A525@webmail.messagingengine.com>
	<1446147967.1951472.423938977.3D386707@webmail.messagingengine.com>
	<CAFLxGvyjM0iaC5cW7Hdy8aU-BctRx8h2-KUso08mx7O_FKkOTw@mail.gmail.com>
	<1446186594.2098205.424343233.1586EFFB@webmail.messagingengine.com>
Date: Fri, 30 Oct 2015 20:31:37 +0100
Message-ID: <CAFLxGvy77pevm20emnnL6JHYJfnZEYYr2mVmby4YCvjqWh8Svw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [uml-user] Website is in need of many small changes
	and updates?
To: Balaco Baco <balacobaco@imap.cc>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>

On Fri, Oct 30, 2015 at 7:29 AM, Balaco Baco <balacobaco@imap.cc> wrote:
>
> On Thu, Oct 29, 2015, at 16:55, Richard Weinberger wrote:
>> On Thu, Oct 29, 2015 at 8:46 PM, Balaco Baco <balacobaco@imap.cc> wrote:
>> >> > > >> > Really!? I wish I had read that somewhere. Well, just retried with
>> >> > > >> > another option that is there for me. It is one of the cases I detailed
>> >> > > >> > before that end with error.
>> >> > > >> >
>> >> > > >>
>> >> > > >> Linux 2.6.24?! SRSLY?
>> >> > >
>> >> > > If you want me to help, please use a recent/supported kernel.
>> >> > > Ready-to-use root filesystems can be found everywhere.
>> >> > > For example: http://fs.devloop.org.uk/
>> >> > >
>> >> >
>> >> > I'm not sure now, but the two Debian root fs I'm using were downloaded
>> >> > from the site you point here. Later I'll check their sums, and PS this
>> >> > in a next message. Kernels 2.6.* were recent and assumed to be supported
>> >> > in most places I could need - or so I assumed.
>> >>
>> >> > What is your definition of recent and your definition of supported? This
>> >> > may be useful for many other users of UML I guess. The fact that the
>> >> > kernels offered in the UML website didn't work, and then I tried to
>> >> > compile from source should be pointed here. I don't think I have done
>> >> > something so weird or uncommon here - mainly because I don't need much
>> >> > as long as I have flexibility to execute it.
>> >>
>> >> Everything that gets -stable updates.
>> >
>> > Website: UML's, http://user-mode-linux.sourceforge.net/, accessed right
>> > now.
>> >
>> > "Getting started" seemed like a good place for me a few weeks ago (and
>> > still does, but...). And I think it will make many users feel and think
>> > the same way I did. Except that it gives us wrong directions - but gives
>> > bad directions for users that will surely follow them without knowing
>> > the wrong details since they're expecting to see something working to
>> > get more familiar with UML. "Download THIS ( pointing to
>> > http://user-mode-linux.sourceforge.net/linux-2.6.24-rc7.bz2) or THIS
>> > (pointing to
>> > http://user-mode-linux.sourceforge.net/linux-2.6.24-x86_64.bz2 )". Are
>> > these kernel versions familiar to you in the list? They are for me, now
>> > I just understood a few more details, and the possible path to solution,
>> > to execution without unexpected problems - or so I hope.
>> >
>> > The thread I started today, quickly skimmed in the above quotes, shows
>> > this. The website needs to be fixed. And more than that, needs to be
>> > updated more frequently (or so I must guess) or write about how users
>> > can be sure their setup is good enough.
>> >
>> > I downloaded both suggested kernels, following the official (and assumed
>> > best, for that) instructions. Both did not work (and still don't). And
>> > the one that worked back then is probably needing something I've
>> > forgotten in these days or stopped to work today. But that one I
>> > compiled from source - and now I need to do it again, from the very
>> > start.
>> >
>> > Everything that gets stable updates... but this should not exclude the
>> > UML website, right?
>>
>> The website is very old and from the pre-mainline time.
>> If you volunteer to update and maintain it it would be wonderful.
>>
>> I'm not a web designer nor do I have the time for this.
>>
>
> Really?! I would never bet that it was that old.
>
> I can update it. And I also have a little bit of web design knowledge
> and practices that may be eventually useful. On the other hand, I would
> need directions and thumbs up to guarantee that the contents are kept
> correct (which would be my main objetive when changing texts). I have
> not programmed that much kernel code and "related or almost so" things,
> although I have a solid C background - and this is something that UML
> seems to have a broad contact surface, from the messages I have read
> here.
>
> At most a month of medium site changes are good as expectations?
> Although most of the time I can give a few hours per week, so that month
> should not look too bad.
>
> What would be the process? If only with you directly, I guess we
> continue to talk about it between us.

Create a concept and share it. :-)

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

