Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSgjj-00050U-Ue	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 12:37:47 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DSgji-000050-8O	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 12:37:47 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] The source to that firmware-uml thing is now up...
References: <200504200606.06828.rob@landley.net>
	<200505011306.39277.blaisorblade@yahoo.it>
	<200505020114.29408.rob@landley.net>
In-Reply-To: <200505020114.29408.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505022138.22658.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 2 May 2005 21:38:22 +0200
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 02 May 2005 07:14, Rob Landley wrote:
> On Sunday 01 May 2005 07:06 am, Blaisorblade wrote:
> > > (That said, if you do use -p to get get a setuid bash, there's several
> > > other things you should do to make this marginally less dangerous.  And
> > > I wouldn't trust myself to remember them all off the top of my head...)

> > No, I'm not saying that a setuid bash won't work because of the bash
> > special code.

> > I'm saying that setuid script plain don't work (the kernel ignores the
> > setuid bit). Except for perl, which has a special mechanism to make them
> > work anyway.

> I got this to work once, a few years back (under an early 2.4 kernel).  The
> setuid bit wasn't on the bash executable (that would be insane), it was on
> the script.

> I don't remember the details (it was a few years ago now) but at one point
> it was possible.  I vaguely remember tracing through both bash and the
> kernel code to see what the heck it was actually doing, and I think there
> was something funky and non-obvious about permissions, or some such...

> And if the perl executable isn't itself suid, then what special mechanism
> can the perl executable have to execute stuff as root if the kernel isn't
> passing it root access when you run the script?  This "special mechanism"
> would either have to be the suid bit on the perl executable (which my
> /usr/bin/perl hasn't got) or some mechanism for cracking root access as a
> normal user, doesn't it?

This mechanism involves having the setuid bit set on /usr/bin/suidperl. Though 
it's documented in man perl<Something>, here's the basics:

*) the kernel can't allow a setuid script to work. There's an inherent race 
condition: fork(), execve() the script, the kernel runs the shell with id = 
0, you modify the file to be nasty and it loses its setuid bit, but still the 
shell is going to open and execute it.

*) perl checks if the script is setuid, and if suidperl is installed, it 
avoids the problem (probably by copying the source somewhere where it can't 
be modified, or something smarter, I don't know).

> No, if I remember correctly bash was the problem, in the same holier than
> thou "we are the FSF, we know better than you because you are dumb and we
> must protect you from yourself" way that gcc's collect2 won't search the
> path for ld if the $PATH has "." in it (even at the end),

> which is the 
> default path in UML by the way.
Sorry, what you mean here? It's the default PATH in your guest image or there 
is actually something in UML leading to that (which would be a bug?).
> (That took a while to track down...)
Ah, I remember your very early message "gcc does not find LD, I can find it by 
hand and it's in the PATH".


> I got that to work once too.  I vaguely recall I had to specify -E
Ignore env. vars such as PYTHONPATH... makes sense to avoid exploits.
> , and 
> possibly some other stuff...

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
