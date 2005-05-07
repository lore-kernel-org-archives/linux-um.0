Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DURK9-0007A6-Ru	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 08:34:37 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DURK9-0006fo-4p	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 08:34:37 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <200505051214.45279.blaisorblade@yahoo.it>
	<427B4F4B.5040909@fujitsu-siemens.com>
In-Reply-To: <427B4F4B.5040909@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505071728.35739.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: NACK on shift-MM_COPY_SEGMENTS for API change
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
Date: Sat, 7 May 2005 17:28:35 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Friday 06 May 2005 13:04, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > I understand the purpose of the patch; however, without any mention about
> > the effects (which would be IMHO bad) we no more copy LDT segments on
> > fork/clone, which is bad.
>
> No. The patch shifts code only, but AFAICS it doesn't alter the bahavior of
> UML/i386. If it does, that would be a bug in the patch!
>
> > The patch moves that to the call of modify_ldt, but that's an hack, since
> > currently it's perfectly legitimate that a child uses the father's LDT,
> > though maybe uncommon.
>
> No. Let's read the code before and after the change:
>
> Before the change, father's LDT is copied in new_mm() using
> MM_COPY_SEGMENTS. new_mm() only has one caller, which is
> init_new_context_skas().

> After the change, father's LDT is copied in init_new_ldt(), again
> using MM_COPY_SEGMENTS.
Ok, it turns out that I was simply misreading the patch (I didn't apply the 
patch, since I don't have the time to work on Jeff's tree too, beyond the 
release tree).
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
