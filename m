Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoW3p-0006r9-Mk for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 16:08:29 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CoW3n-0006wz-02 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 16:08:29 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] df -h and hostfs
References: <62845.80.203.0.208.1105438274.squirrel@80.203.0.208>
In-Reply-To: <62845.80.203.0.208.1105438274.squirrel@80.203.0.208>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501120110.32416.blaisorblade@yahoo.it>
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
Date: Wed, 12 Jan 2005 01:10:32 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: stian@nixia.no

On Tuesday 11 January 2005 11:11, stian@nixia.no wrote:
> when df -h does a statfs, hostfs statfs'es /, instead of the mount-source
> directory,
I.e. the one you see in the mount point inside UML...
> so you get the wrong stats about free-space if the mounted 
> directory does not originate from the / host partition.

Yes, good idea... fixing it like you said will guarantee correct free space 
stats (apart for quotas) but not correct used-space and total-space stats 
(they would be possible only for humfs if it uses some accounting).
> Stian
However, by looking the code, I don't see an obvious way to trigger this 
bug...

In: 
static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
{
We have:
        HOSTFS_I(root_inode)->host_filename = name;
And later, this value is reused (I actually checked this is supposed to refer 
to the same thing) as:
        err = do_statfs(HOSTFS_I(sb->s_root->d_inode)->host_filename,

So, could you double-check? I'll also try to reproduce it, if possible.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
