Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <50376.130.217.250.13.1069985464.squirrel@webmail.scms.waikato.ac.nz>
In-Reply-To: <Pine.LNX.4.53L0.0311271721550.27408@alpha.temple-baptist.com>
References: 
    <Pine.LNX.4.44.0311280047120.28924-100000@filer.marasystems.com><010c01c3b54d$99552830$2000000a@schlepptopp>
    <Pine.LNX.4.53L0.0311271721550.27408@alpha.temple-baptist.com>
From: "Shao-Lin Joseph Chung" <sc57@cs.waikato.ac.nz>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] How to copy COW files to another machine across the network?
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
Date: Fri, 28 Nov 2003 15:11:04 +1300 (NZDT)
To: UML User list <user-mode-linux-user@lists.sourceforge.net>
Cc: UML Devel list <user-mode-linux-devel@lists.sourceforge.net>

As the subject says, I'm trying to copy the COW files across the network. 
But the size of those copies got expanded to the same size of the backing
file.

Is there a way to keep these COWs small & cute?  ;-)

Thanks for help.

Joseph


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
