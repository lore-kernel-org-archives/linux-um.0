Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <41F82DF4.10506@rimuhosting.com>
From: Peter <p.repliesignored@rimuhosting.com>
MIME-Version: 1.0
References: <200501262310.49814.blaisorblade@yahoo.it>
In-Reply-To: <200501262310.49814.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] [POLL] Putting UML/2.4 into "fixes-only"
	mode
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
Date: Thu, 27 Jan 2005 12:55:32 +1300
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

+1

For my purposes I need solid, stable code.  I prefer a a 2.4 and 2.6 
kernel that builds without too many config gotchas.  And runs reliably. 
  e.g. right now I am using the blaisorblade 2.6.9-bs patches and the 
pre-hostfs 2.4 code.  That works well.

I'm all for different UML trees/patches that try out new features and 
make major changes.  And I will contribute to testing those if needed. 
But I would like to keep those patches/trees separate from the 'stable' one.

It is your time, and you can spend it how you like (obviously).  I'd be 
most happy if new work went into the 2.6 tree if that meant more would 
be done.  That seems to be where all new distros are going (not 2.4). 
And (give or take a bug or two) most of my UML instances run really well 
on the 2.6 tree.  If I had a really solid 2.6 kernel I don't think I'd 
even need the 2.4 one.

So if you can save some backporting efforts, work on adding more 2.6 
stability and new features (on the separate -mm type tree) that could be 
a win-win.

Cheers, Peter



Blaisorblade wrote:
> Jeff, I've seen the beginning of your work on back-porting all the patches 
> from 2.6 to 2.4...
> 
> It's a huge work, but what is more important, it could obviously hurt 
> stability...
> 
> So, I'd suggest to follow this policy to choose the work to merge:
> 
> - reduce *a lot* what is going to be merged... no new features, no code 
> cleanups (especially NOT the Makefiles cleanups)...
> 
> - concentrate on stability... and on backing out the hostfs rewrite.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
