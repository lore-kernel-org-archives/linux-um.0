Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRa2C-0002vi-R7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 09:44:00 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CRa28-0004pd-MC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 09:44:00 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: 2.6.9-bb1, 2.4.27-bs1, SKAS3/2.6-V7 released
References: <200411041932.39733.blaisorblade_spam@yahoo.it>
	<871xf4a5kc.fsf@aka.i.naked.iki.fi>
In-Reply-To: <871xf4a5kc.fsf@aka.i.naked.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411091241.06637.blaisorblade_spam@yahoo.it>
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
Date: Tue, 9 Nov 2004 12:41:06 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nuutti Kotivuori <naked@iki.fi>, linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net

On Monday 08 November 2004 13:28, Nuutti Kotivuori wrote:
> Blaisorblade wrote:
> > Changes in both 2.6.9 and 2.4.27:
> > they run fine on 2.6.9 host kernels, without hanging at the exit.
>
> I want to get this clear:

> Every older guest UML kernel will hang on exit on 2.6.9 hosts from now
> on, and there's nothing to fix it but to update the guest UML patches?

> This is a nasty limitation in general - because it means that on the
> update to 2.6.9, every kernel binary needs to be updated - and finding
> rock solid versions of kernels + UML patches is not a fast process.

Yes, I perfectly agree with you. However, there are, for 2.6, the security 
fixes which are needed.

Well, it is possible that 2.6.10 (or even 2.6.11) will make again old UML 
binaries work. I.e., this is my hope, but no code is ready for this, yet.

In fact, Linus always said "binary compatibility is important".

UML was using a strange undocumented, and unwanted interface, but this is not 
a good reason for the kernel to break it. I think they did not even notice 
that. Also, however, I find that the breakage is a real bug.

The splitout version of the patches is available, and the 
uml-hang-on-2.6.9-host.patch is the one to apply. For 2.4, it cannot be 
applied separately, though (it requires one of the current incrementals, 
which is included in the patchset).

Unfortunately, it does not work on most kernel versions - it can be adapted, 
though, and if I find time, I will.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
