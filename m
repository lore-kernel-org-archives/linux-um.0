Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: s-uml@rhythm.cx
Message-ID: <20040118162345.GA23424@infinity.rhythm.cx>
References: <4009A583.7070007@lig.net>
	<20040118044551.GB8571@ccure.user-mode-linux.org>
	<400A30CC.20308@lig.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400A30CC.20308@lig.net>
Subject: [uml-devel] Re: [uml-user] Dynamic remount with variable COW
	stacking/merging needed, support for snapshot repilication
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
Date: Sun, 18 Jan 2004 11:23:45 -0500
To: "Stephen D. Williams" <sdw@lig.net>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Sun, Jan 18, 2004 at 02:07:56AM -0500, Stephen D. Williams wrote:
> Yes, but that doesn't meet the key requirement I am proposing: that the 
> downtime be limited to a few seconds. 

If you use the LVM on the host you can take a snapshot of the volume the ubd
images are on while the uml is stopped. The snapshot gets made instantly so
the uml would be stopped for very little time. 


-Steve


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
