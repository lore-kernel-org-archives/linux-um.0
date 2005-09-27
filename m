Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Alasdair G Kergon <agk@redhat.com>
Subject: Re: [uml-devel] Re: Writing on DM snapshots, and having no
	"mainstream" device (was: Re: Fw: [PATCH 1/7] Add dm-snapshot tutorial in
	Documentation)
Message-ID: <20050927183430.GN18976@agk.surrey.redhat.com>
References: <20050920163433.6081be3b.akpm@osdl.org>
	<200509232211.32238.blaisorblade@yahoo.it>
	<20050923211953.GG18976@agk.surrey.redhat.com>
	<200509261703.01567.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509261703.01567.blaisorblade@yahoo.it>
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
Date: Tue, 27 Sep 2005 19:34:30 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Alasdair G Kergon <agk@redhat.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-user@lists.sourceforge.net

On Mon, Sep 26, 2005 at 05:03:01PM +0200, Blaisorblade wrote:
> You also "fixed" my assertion that snapshot-origin "base device" (parameter 
> n.1) must be a DM device. Should I readd it too?
 
That parameter does not need to be a DM device if you are able to use
the start of an existing block device (so you don't require any mappings).

> IIRC I checked the code and it looks up the first param as a DM device, 

It should only use the device number for reference, not any dm structure.

Try it.

Alasdair
-- 
agk@redhat.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
