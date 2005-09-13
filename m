Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFFWD-0005Bg-I0	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Sep 2005 11:28:33 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EFFW9-0005Q0-NK
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Sep 2005 11:28:33 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection
	support (for UML), try 3
References: <200508262023.29170.blaisorblade@yahoo.it>
	<200509042110.01968.blaisorblade@yahoo.it>
	<Pine.LNX.4.61.0509071259380.17612@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509071259380.17612@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509132025.16015.blaisorblade@yahoo.it>
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
Date: Tue, 13 Sep 2005 20:25:15 +0200
To: Hugh Dickins <hugh@veritas.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>, jdike@addtoit.com, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Wednesday 07 September 2005 14:00, Hugh Dickins wrote:
> On Sun, 4 Sep 2005, Blaisorblade wrote:
> > On Friday 02 September 2005 23:02, Hugh Dickins wrote:
> > > On Fri, 26 Aug 2005, Blaisorblade wrote:
> > > > * The first 2 patches modify the PTE encoding macros and start
> > > > preparing the VM for the new situation (i.e. VMA which have variable
> > > > protections, which are called VM_NONUNIFORM. I dropped the early
> > > > VM_MANYPROTS name).

> If it's something pervasive, like such naming, then yes you should redo
> the patches.  Minor local corrections can be appended as an additional
> patch, so long as they don't make the original patch ridiculous.
>
> I don't understand your "(at least when not changing behaviour)":
> if you mean that significant changes of behaviour should be done as extra
> patches at the end, no: surely they should be patches of the main sequence.
Perfectly fine.
> All of this supposes that my opinion is to be followed.
> I've given my opinions, Andi gave his, I don't remember others.
> It doesn't mean any one of us is right.  Did you agree with mine?
For me it's no problem renaming, I see your point, have no particular reason 
to insist with mine.

> > > "Inherit" is about parents and children, this is not;
[...]

> > MAP_CHGPROT? MAP_CHANGEPROT? MAP_REPROT?
> > VM_MANYPROTS is internal name, so there's no reason to have the same name
> > either.

> It doesn't have to be the same name, true, but I find it a lot easier
> to follow the trail of functionality when similar naming is used.
> Perhaps the "PROT" part is enough: MAP_SETPROT or MAP_CHGPROT or
> MAP_CHANGEPROT if you don't like MAP_MANYPROTS.
MAP_CHGPROT is perfectly ok...
> > It's just what you remarked above. But we'd have separate macros and code
> > paths (not hugely separate): use the old macro version if VM_MANYPROTS
> > clear, use the new one if VM_MANYPROTS set.

> I think those macros are grotesque enough already.
That change wouldn't be in the macro themselves. We'd have a slightly 
different path in the caller to handle that.
> But I don't have a constructive suggestion.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
