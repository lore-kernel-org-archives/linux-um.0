Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] How to copy COW files to another machine across the
 network?
In-Reply-To: <50376.130.217.250.13.1069985464.squirrel@webmail.scms.waikato.ac.nz>
Message-ID: <Pine.LNX.4.44.0311280940300.3315-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 28 Nov 2003 09:49:41 +0100 (CET)
To: Shao-Lin Joseph Chung <sc57@cs.waikato.ac.nz>
Cc: UML User list <user-mode-linux-user@lists.sourceforge.net>, UML Devel list <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 28 Nov 2003, Shao-Lin Joseph Chung wrote:

> As the subject says, I'm trying to copy the COW files across the network. 
> But the size of those copies got expanded to the same size of the backing
> file.

You can't move COW files around unless you make a tool to adjust the COW
file header after the move. If not UML will disregard the COW file as
invalid and revert to the backing file copy.. UML checks that the 
following parameters match the backing file
  * Full file name including path
  * File size
  * Modification timestamp

Regarding the size: You need to use a copying tool which accounts for 
holes in the file. See for example the --sparse option to cp.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
