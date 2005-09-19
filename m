Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHFrU-0006hs-Bq	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Sep 2005 00:14:48 -0700
Received: from zproxy.gmail.com ([64.233.162.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EHFrR-0002ws-Ma
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Sep 2005 00:14:48 -0700
Received: by zproxy.gmail.com with SMTP id 14so419774nzn
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 Sep 2005 00:14:39 -0700 (PDT)
Message-ID: <432E7091.8090403@gmail.com>
From: Victor Condino <un1tz3r0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000008070203090506020606"
Subject: [uml-devel] Waiting for data on host FD
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
Date: Mon, 19 Sep 2005 04:02:25 -0400
To: UML Developer Mailing List <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000008070203090506020606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have a some test code which basically creates a proc file within uml
which you can attach to a pair of host file descriptors using a command
line option. The idea here is to be able to run programs inside uml
with their input/output piped to/from processeses on the host.

My issue is with os_read_file()... initially, I used blocking I/O on the
host file descriptor with a single call to os_read_file() in the proc
entry's f_ops->read callback. I found out pretty quick that calling
system calls using blocking I/O locks up the whole user-mode kernel.

So, after browsing through the sources in arch/um/drivers/, I took some
pretty easy to understand code that uses nonblocking I/O and calls
schedule_timeout in a loop until a non-blocking read returns some data.
Here is my code for the procfile read callback and the schedule/read
loop helper...


static int hostfd_in = -1;
  ...

static ssize_t os_read_interruptible(int fd, struct file *filp,
  char *buf, size_t size, loff_t * offp)
{
  int n, ret = 0, err;

  err = os_set_fd_block(fd, 0);
  if(err != 0) {
    return err;
  }

  while(size) {
    n = os_read_file(fd, buf, size);
    if(n > 0) {
      return n;
    } else if(n == -EAGAIN) {
      if (filp->f_flags & O_NONBLOCK) {
        return ret ? : -EAGAIN;
      }
      if(need_resched()) {
        current->state = TASK_INTERRUPTIBLE;
        schedule_timeout(1);
      }
    } else {
      return n;
    }
    if (signal_pending (current)) {
      return ret ? : -ERESTARTSYS;
    }
  }
  return ret;
}


static ssize_t hostfd_read(struct file *file, char *userbuf, size_t len,
  loff_t * offset)
{
  char *tmpbuf = NULL;
  int i = 0;

  if(hostfd_in < 0)
    return -EIO;

  tmpbuf = kmalloc(len, GFP_KERNEL);
  if(!tmpbuf)
    return -ENOMEM;

  i = os_read_interruptible(hostfd_in, file, tmpbuf, len, offset);

  if(i > 0) {
    if(copy_to_user(userbuf, tmpbuf, i)) {
      i = -EFAULT;
      goto out;
    }
  } else if(i == -EAGAIN) {
    i = 0;
    goto out;
  } else if(i == 0) {
    i = -EIO;
    goto out;
  }

out:
  kfree(tmpbuf);
  return i;
}


This is does the job, but while the os_read_interruptible helper is
waiting for data to arrive, since the time we wait before attempting
another non-blocking read is very short, the uml process uses a pretty
significant amount of the host's cpu cycles. I could increase the
timeout interval, but at the cost of extra latency between when data
actually becomes available on the fd and when we come back from the
schedule_timeout call to get it. This is obviously a suboptimal method.

So my question is: what is the right way to go about waiting for host
I/O to become available on a givel FD? It seems from looking at the uml
drivers that um_request_irq is used to request notification of various
asynchronous events from the host. If this can be used for waiting until
an fd is available for read or write, how? I tried looking around for
some code that uses um_request_irq for read/write, but couldn't seem to
find any.

If I am completely wrong about um_request_irq, then is there a mechanism
implented in UML for sleeping until a host FD becomes available? If not,
I assume that maybe it could be done with a helper process?

Thanks very much for your help!

- - V. Condino

(I appologize for bothering the UML developers with specific "How do I?"
questions... I'm not new to kernel programming, but some of the more
complicated aspects of UML's kernel APIs and implementation are still a
little .)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDLnCJuFIK+j0m2f8RAkRgAKDKIl7fXnnaH+GMBNGwrfh/OkInQgCfYdcB
t7BLb2INkLiAyV77z2Wo2Z8=
=UmYA
-----END PGP SIGNATURE-----

--------------000008070203090506020606
Content-Type: application/pgp-keys;
 name="0x7DBFE136.asc"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="0x7DBFE136.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdudVBHIHYx
LjQuMSAoR05VL0xpbnV4KQoKbVFHaUJFSzZoeWdSQkFDNUczd3c0ZVNsL1dFcFQxdE9SaXhE
dEdoSERFM0dSTzYxYk1iYWEwS2dTUFdKcm02Tgo2TW9PRS9DV2gyTGI2ekNlMEY4MDRtNGox
UUxuZE9vOVdFZXRUaGJTSHhhVkNnbXg3MWFndDJVbTJrcEt3OVQ4CmVXUzZuQlRjVjZyVmtG
aGZ6WXE4VkVjN0s1MUxYWGhHNGxsTjNVaUlxMEhDQlRvalh0VnhGMkdVQndDZ2piUlkKLzdi
M2w4MHJ4RDdzMjRQcW1zdktmZmtELzNGeVplV1lSaGMrSy80QWNqQlhSaEFhQ1d5bm1BbDJF
K0d5QWkySQppc0tqdG43aHJDWG00ODNnM3dka25EK1luaEpyT3JEOFRLL1ZzS3dHQngrU3Qv
N3NuUEg4VGlzT2VRSkJUSFBjCmhYaW5zUDNrcEs5VUxkMVdTRlNnMXB3eTBpYVBMeWxHdDZw
NGU3clFsWkltTDVGZU94ckx1ekcxcVcwL1ZNVDMKNk9kK0EvOW1UVmFxWDIyOHNmWlNWelVE
OXBrVHkyZ0ZUUHUzMm1aWjRwcFRQVnpYbXBEZjFnWDg1eGJCY2RiNgo4OXg3ZlZhTW96UkZQ
ZmpTTk9yTjVoaStvaHFrbEpRdE1ibzhmYm9CTkNKaEhndWVTYi9McjQzaHBJNnIvMTFDCmZO
encyVThXbTlCWGlsK3RYTldPT000ZWxRZmNUU2NLUmZETEpkaG9FdDl0MlZISUpiUWpWbWxq
ZEc5eUlFTnYKYm1ScGJtOGdQSFZ1TVhSNk0zSXdRR2R0WVdsc0xtTnZiVDZJWUFRVEVRSUFJ
UVVDUXJxSEtBVUpDV1lCZ0FZTApDUWdIQXdJREZRSURBeFlDQVFJZUFRSVhnQUFLQ1JCYm1E
eVpmYi9oTmhXOEFKNHIxL25oWEpYVnRzS2ZYMWxqCmw3NGR1UHlQZkFDWFpZVXVoSDJmd3dk
OCtDREdGVC83b0twZ1Rya0NEUVJDdW9jMkVBZ0F2UGFPaHFVRUJrK0EKWXltQTRvTm02RFIr
RExtZkVGS2owc0loQUVtNTBCN0w2b1VzbFFkMWJkM2d0MDBPcURlbUU3U1dYY3duNzQ3VwpS
UHhhSXIrMnRiRXhNZ1ovR2htKzNjc2NlcDljTGU3bkxIWm5pYnBRNEtQWFpQUG1oakFvWERD
RGJlT09sdjdnCkJrbnJFOE5rdCsrNzg2WUJLUUIwb3Bra2t1RFo4UXNLbDVFSm14azI0dVBm
VDlMa2kreUN4ZTBjN0hldjJKTDcKS1JUSjRnTHZ4Wi95VUxuaXU4bUFKSE5OS2dhK2RvRTdR
Zi9PQTJSTk42Q3Z1NmMzTkE5WXY5QlhUbmdEckhTZApROFAybEdNc3EzMGF1NWlLc0habUV5
bFJRVmhHUW54TnB0VGhlVnltVmN5YlA5V3VoeDZPQWhCOERkQzZSb2ZJCnJ5eWV3azdCN3dB
RURRZi9VL211ajdqeklTdEhoL0lNYkx1WVVGb0ZjMTFWSkRySkZ3bmVaMCs0bnVEWWhpQ3kK
UC9IMXdiUzBqcTNodkxxcUtySWVLR2w2bU1ZcWJNK042VHFXZklXTkVPcWlFNjFKQk1EQjlq
RmFXYlhMMHc0ZApFQ2lqVVJnNi8ycG1VRGphNDBoNGo0M1dvQnZudXF1cXFsblk2NnRHYXR5
L2FTc094WmdNeU9IY0g4TDJoc1lICnRmODlVWTNRR2ZVaFdWWXArdUczR3JnK3R5M1RCS2pq
cWR0WlhrbW12d3VETHQxbnNpR0JWeE5GK2JZMDFJNzQKNzFRZDhlVzhtNzJacFVtcjN2a1lU
M0tBVTJJTzBRa2FGQXBtN1orelZOSE1BNFBjMm5xeUJnNUxNUVN1cXVCcwpmU2lyUkRCNnlr
dytnaFp6VmJhMGhMaTAzdkRHNk9zTFVURFptb2hNQkJnUkFnQU1CUUpDdW9jMkJRa0paZ0dB
CkFBb0pFRnVZUEpsOXYrRTJXa29BbjEycFBSWXVBYU14enJBYyt6U1VvWnBNZ25UaEFKOTJE
N0VpV3RISU54ZmIKTDRtRHovczEyUWU2cFE9PQo9d3V3NQotLS0tLUVORCBQR1AgUFVCTElD
IEtFWSBCTE9DSy0tLS0tCg==
--------------000008070203090506020606--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
