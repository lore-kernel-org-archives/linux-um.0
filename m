Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DU0da-0003jt-EV	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 04:04:54 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DU0dZ-0007Ny-Qs	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 04:04:54 -0700
Message-ID: <427B4F4B.5040909@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <200505051214.45279.blaisorblade@yahoo.it>
In-Reply-To: <200505051214.45279.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 06 May 2005 13:04:43 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> I understand the purpose of the patch; however, without any mention about the 
> effects (which would be IMHO bad) we no more copy LDT segments on fork/clone, 
> which is bad.
No. The patch shifts code only, but AFAICS it doesn't alter the bahavior of UML/i386.
If it does, that would be a bug in the patch!
> 
> The patch moves that to the call of modify_ldt, but that's an hack, since 
> currently it's perfectly legitimate that a child uses the father's LDT, 
> though maybe uncommon.
No. Let's read the code before and after the change:

Before the change, father's LDT is copied in new_mm() using MM_COPY_SEGMENTS.
new_mm() only has one caller, which is init_new_context_skas().

After the change, father's LDT is copied in init_new_ldt(), again
using MM_COPY_SEGMENTS.
init_new_ldt() also has exactly one caller, which again is init_new_context_skas().

In both cases, copying is done only, if /proc/mm is available.
So, nothing in the behavior is changed, but the code is shifted to arch-specific
files.
> 
> It would be better to move LDT copying to an arch-specific helper, defaulting 
> to null (i.e. an empty inline) and defined only for i386 and x86-64 (even the 
> same def. is ok, probably).
Yeah. init_new_ldt() exactly *is* such a arch-specific helper.
In UML/s390, this is a NOOP.

BTW: my UML/i386 uses a libc, that depends on modify_ldt() to manage the TLS.
If UML doesn't copy the LDT, this system crashes. And it works fine with the
changes!

Regards,
      Bodo


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
