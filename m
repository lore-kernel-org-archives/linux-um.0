Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBsQm-000655-2E for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Apr 2004 02:36:12 -0700
Received: from smtp.wp.pl ([212.77.101.160])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BBsQl-0000I5-JG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Apr 2004 02:36:11 -0700
Received: from host-116-243.rev.vline.pl (HELO [172.16.13.24])
	(sikkh@[217.76.116.243]) (envelope-sender <sikkh@wp.pl>)
	by smtp.wp.pl (wp-smtpd) with RC4-MD5 encrypted SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	9 Apr 2004 11:35:57 +0200
From: Piotr Neuman <sikkh@wp.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404091137.16728.sikkh@wp.pl>
Subject: [uml-devel] Simple db with separable io layer for humfs metadata.
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
Date: Fri, 9 Apr 2004 11:37:16 +0200
To: user-mode-linux-devel@lists.sourceforge.net

As Jeff Dike had requested that humfs db should allow UML to do actuall IO, I 
have found 2 simple db-es suitable for such task. I was however unable to 
find one that would have clear distinction of IO operations, like for example 
using another lib to do it. My findings:

TDB: http://sourceforge.net/projects/tdb/ (it's used in samba project)

Need only reimplement 2 pretty simple functions:
static int tdb_write(TDB_CONTEXT *tdb, tdb_off off, void *buf, tdb_len len)
static int tdb_read(TDB_CONTEXT *tdb,tdb_off off,void *buf,tdb_len len,int cv)

The whole db is just two files: tdb.c and tdb.h which weight around 49KB, so 
shipping it along with UML would be no problem imo.

For example (to show difficulty of reimplementing):

static int tdb_write(TDB_CONTEXT *tdb, tdb_off off, void *buf, tdb_len len)
{
	if (tdb_oob(tdb, off + len, 0) != 0)
		return -1;

	if (tdb->map_ptr)
		memcpy(off + (char *)tdb->map_ptr, buf, len);
#ifdef HAVE_PWRITE
	else if (pwrite(tdb->fd, buf, len, off) != (ssize_t)len) {
#else
	else if (lseek(tdb->fd, off, SEEK_SET) != off
		 || write(tdb->fd, buf, len) != (ssize_t)len) {
#endif
		TDB_LOG((tdb, 0,"tdb_write failed at %d len=%d (%s)\n",
			   off, len, strerror(errno)));
		return TDB_ERRCODE(TDB_ERR_IO, -1);
	}
	return 0;
}

QDBM: http://qdbm.sourceforge.net/

In this case need to reimplement 4 functions (also simple):
static int dpwrite(int fd, const void *buf, int size);
static int dpseekwrite(int fd, int off, const void *buf, int size);
static int dpread(int fd, void *buf, int size);
static int dpseekread(int fd, int off, void *buf, int size);

Basic setup is: depot.c, depot.h, myconf.c and myconf.h - ~86KB. But 
additional b+tree support allows for gracious recovery after crash, and 
smaller file size than tdb at the cost of increasing code size to ~308KB. 
qdbm is generally much more advanced and featurefull than tdb. It also has 
plenty of interfaces to other languages, like perl (not counted in that size 
approximation).

Example:

static int dpseekwrite(int fd, int off, const void *buf, int size){
  char *lbuf;
  assert(fd >= 0 && buf && size >= 0);
  if(size < 1) return TRUE;
  lbuf = (char *)buf;
  if(off < 0){
    if(lseek(fd, 0, SEEK_END) == -1){
      dpecode = DP_ESEEK;
      return FALSE;
    }
  } else {
    if(lseek(fd, off, SEEK_SET) != off){
      dpecode = DP_ESEEK;
      return FALSE;
    }
  }
  if(dpwrite(fd, lbuf, size) != size){
    dpecode = DP_EWRITE;
    return FALSE;
  }
  return TRUE;
}

Regards to UML developement team (Jeff Dike that is ;)


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
