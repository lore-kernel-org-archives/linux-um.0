Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Tue, 5 Jun 2007 12:27:43 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070605162743.GA6946@c2.user-mode-linux.org>
References: <7694D1D9D7B18142A440B52FA1E4AB9702AA5C64@CHN-SNR-MBX01.wipro.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7694D1D9D7B18142A440B52FA1E4AB9702AA5C64@CHN-SNR-MBX01.wipro.com>
Subject: Re: [uml-devel] modprobe: Can't locate module scsi_debug
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: rajasekhar.pulluru@wipro.com
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, rashmi.biswal@wipro.com

On Tue, May 29, 2007 at 08:37:44PM +0530, rajasekhar.pulluru@wipro.com wrote:
> Hi,
> Am a newbie to linux and UML. I have been trying to modprobe the
> scsi_debug,
> [root@mandrake82 host]# modprobe scsi_debug
> modprobe: Can't locate module scsi_debug
> 
> Could someone help me to modprobe successfully? 

You build the modules in the UML kernel pool, then copy them into the
UML filesystem - a good way is loop-mounting the UML filesystem and
doing a modules_install with the install directory being /lib in the
loopback mount.

> [root@mandrake82 2.4.20-8um]#

You might try something more modern than this - if you have any
trouble with it, no one will be able to help.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
