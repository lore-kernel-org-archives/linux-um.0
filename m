Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYUaS-0003mU-Ot
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 22 Dec 2003 10:15:24 -0800
Received: from andromeda.oftc.net ([80.190.233.18])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.24)
	id 1AYUaS-0002on-Cb
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 22 Dec 2003 10:15:24 -0800
Received: from [24.102.64.193] (helo=willow.eelf.ddts.net)
	by andromeda.oftc.net with asmtp (TLS-1.0:RSA_ARCFOUR_SHA:16)
	(Exim 4.24)
	id 1AYUaP-0003R6-RZ
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 22 Dec 2003 18:15:22 +0000
From: David B Harris <dbharris@eelf.ddts.net>
Subject: Re: [uml-devel] skas patch 2.6.0 -A4 mistake
Message-Id: <20031222131517.1045e5dd.dbharris@eelf.ddts.net>
In-Reply-To: <20031222090707.GC9354@alcor.net>
References: <354202003164938-nicospam@sengena.com>
	<20031220235615.GA1710@elte.hu>
	<20031222021055.28b90296.dbharris@eelf.ddts.net>
	<20031222090707.GC9354@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 22 Dec 2003 13:15:17 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, 22 Dec 2003 01:07:07 -0800
Matt Zimmerman <mdz@debian.org> wrote:
> On Mon, Dec 22, 2003 at 02:10:55AM -0500, David B Harris wrote:
> 
> > fsck.ext3: error while loading shared libraries: /lib/libcom_err.so.2: cannot read file data: Error 38
> 
> Errno 38 is ENOSYS.  See #224431/#224502.

Thanks.


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
