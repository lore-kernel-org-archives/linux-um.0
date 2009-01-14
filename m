Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Wed, 14 Jan 2009 15:48:03 +0100
From: Luca Bigliardi <shammash@artha.org>
Message-ID: <20090114144803.GJ3897@pintsize>
References: <20090111142906.6d8b1795@mistral.stie>
	<9bd6b5360901130057j64a962e7p299b26acc37feffc@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9bd6b5360901130057j64a962e7p299b26acc37feffc@mail.gmail.com>
Subject: Re: [uml-devel] [uml-user] Error building with VDE
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
To: sniper <s3c24xx@gmail.com>
Cc: user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>, lanas <lanas@securenet.net>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Jan 13, 2009 at 04:57 PM, sniper wrote:


> Anybody notices this? UML in the latest linus-git has the same problem.


Yes, I've posted a patch to -devel list in July, but it seems nobody merged
it. Look for Message-ID: <20080720143929.GD21627@pintsize> 
(I'm sorry but I can't browse the web archive at the moment).

Basically you have to use uml_kmalloc() instead of kmalloc().


HTH,

luca

-- 
Beware of programmers who carry screwdrivers.
                        -- Leonard Brandwein

http://shammash.homelinux.org/ - http://www.artha.org/ - http://www.yue.it/

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
