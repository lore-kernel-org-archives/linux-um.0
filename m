Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <3FF59C5D.3000408@timesys.com>
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Suspend to disk of uml session?
References: <01a501c3d14d$33b235b0$6f01a8c0@alex>
In-Reply-To: <01a501c3d14d$33b235b0$6f01a8c0@alex>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 02 Jan 2004 11:29:17 -0500
To: Alexander Newald <alexander@newald.de>
Cc: User-mode-linux-user@lists.sourceforge.net, User-mode-linux-devel@lists.sourceforge.net

This project does exactly that: http://sbuml.sourceforge.net/

Alexander Newald wrote:

>Hello,
>
>I wonder if it is possible to add or use a features like "suspend to disk"
>for an uml session.
>
>Like: Somehow (uml_console) call a feature that will pause the uml and write
>all of its "ram" to a file and than end the uml session. After that I copy
>the disk image, the uml linux binary and the "ram" file to another mashine
>and resume the uml.
>
>Thanks for reading this litte curious message.
>
>Alexander Newald
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: IBM Linux Tutorials.
>Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
>Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
>Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
>_______________________________________________
>User-mode-linux-devel mailing list
>User-mode-linux-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
>  
>



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
