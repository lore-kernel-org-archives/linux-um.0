Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GBCfp-0007qV-4p for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 08:42:17 -0700
Received: from wr-out-0506.google.com ([64.233.184.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GBCfo-0003IV-Mg
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 08:42:17 -0700
Received: by wr-out-0506.google.com with SMTP id 37so88032wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 10 Aug 2006 08:42:15 -0700 (PDT)
Message-ID: <39134b110608100842p5acdf798o807b48801ea9a706@mail.gmail.com>
Date: Thu, 10 Aug 2006 23:42:14 +0800
From: "wang lianwei" <lianwei.wang@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] UML hostfs bugs
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0403300631=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============0403300631==
Content-Type: multipart/alternative; 
	boundary="----=_Part_82190_30527524.1155224534229"

------=_Part_82190_30527524.1155224534229
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

There is a bug with UML kernel, some host directory can not be read, for
example "ls /mnt/host/usr/lib", this command is dead until you press CTRL+c.
I test it with Redhat Enterprise Linux 4.


This is because the UML read host directory through opendir, seekdir,
readdir and telldir. When get the dir stream offset through telldir, it
always return 0 on some directory, for example".", I don't know why? But
we can fix it as follows although the next dir entry offset is not exact:


Modify the fs/hostfs/hostfs_user.c file, update the read_dir function,

char *read_dir(void *stream, unsigned long long *pos,
               unsigned long long *ino_out, int *len_out)
{
        DIR *dir = stream;
        struct dirent *ent;
        unsigned long long oldpos;

        oldpos = *pos;

        seekdir(dir, *pos);
        ent = readdir(dir);
        if(ent == NULL)
        {
                return(NULL);
        }
        *len_out = strlen(ent->d_name);
        *ino_out = ent->d_ino;
        *pos = telldir(dir);

        /* Fix the telldir return 0 error */
        if (*pos == 0)
                *pos = oldpos + *len_out;

        return(ent->d_name);
}

although the next offset is not exact, but the readdir can get the next
entry correct.

Can anyone give a better solution?

------=_Part_82190_30527524.1155224534229
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: base64
Content-Disposition: inline

PGRpdj48c3BhbiBjbGFzcz0iMzcyMzgyODE2LTA0MDgyMDA2Ij48Zm9udCBzaXplPSIyIj5IaSBh
bGwsPC9mb250Pjwvc3Bhbj48L2Rpdj4KPGRpdj48c3BhbiBjbGFzcz0iMzcyMzgyODE2LTA0MDgy
MDA2Ij48Zm9udCBzaXplPSIyIj48L2ZvbnQ+PC9zcGFuPiZuYnNwOzwvZGl2Pgo8ZGl2PjxzcGFu
IGNsYXNzPSIzNzIzODI4MTYtMDQwODIwMDYiPjxmb250IHNpemU9IjIiPlRoZXJlIGlzIGEgYnVn
IHdpdGggVU1MIGtlcm5lbCwgc29tZSBob3N0IGRpcmVjdG9yeSBjYW4gbm90IGJlIHJlYWQsIGZv
ciBleGFtcGxlICZxdW90O2xzIC9tbnQvaG9zdC91c3IvbGliJnF1b3Q7LCB0aGlzIGNvbW1hbmQg
aXMgZGVhZCB1bnRpbCB5b3UgcHJlc3MgQ1RSTCtjLiBJIHRlc3QgaXQgd2l0aCBSZWRoYXQgRW50
ZXJwcmlzZSBMaW51eCA0Lgo8L2ZvbnQ+PC9zcGFuPjwvZGl2Pgo8ZGl2PjxzcGFuIGNsYXNzPSIz
NzIzODI4MTYtMDQwODIwMDYiPjxmb250IHNpemU9IjIiPjwvZm9udD48L3NwYW4+Jm5ic3A7PC9k
aXY+CjxkaXY+PHNwYW4gY2xhc3M9IjM3MjM4MjgxNi0wNDA4MjAwNiI+PGZvbnQgZmFjZT0iy87M
5SIgc2l6ZT0iMiI+PC9mb250Pjwvc3Bhbj4mbmJzcDs8L2Rpdj4KPGRpdj48c3BhbiBjbGFzcz0i
MzcyMzgyODE2LTA0MDgyMDA2Ij48Zm9udCBzaXplPSIyIj5UaGlzIGlzIGJlY2F1c2UgdGhlJm5i
c3A7VU1MIHJlYWQgaG9zdCZuYnNwO2RpcmVjdG9yeSB0aHJvdWdoIG9wZW5kaXIsIHNlZWtkaXIs
IHJlYWRkaXIgYW5kIHRlbGxkaXIuJm5ic3A7V2hlbiBnZXQgdGhlIGRpciBzdHJlYW0mbmJzcDtv
ZmZzZXQgdGhyb3VnaCB0ZWxsZGlyLCBpdCBhbHdheXMmbmJzcDtyZXR1cm4gMCBvbiBzb21lIGRp
cmVjdG9yeSwgZm9yIGV4YW1wbGUmcXVvdDsuJnF1b3Q7LCBJIGRvbid0IGtub3cgd2h5PyZuYnNw
O0J1dCB3ZSZuYnNwO2NhbiBmaXgmbmJzcDtpdCBhcyBmb2xsb3dzIGFsdGhvdWdoIHRoZSBuZXh0
IGRpciBlbnRyeSBvZmZzZXQgaXMgbm90IGV4YWN0Ogo8L2ZvbnQ+PC9zcGFuPjwvZGl2Pgo8ZGl2
PjxzcGFuIGNsYXNzPSIzNzIzODI4MTYtMDQwODIwMDYiPjxmb250IGZhY2U9IsvOzOUiIHNpemU9
IjIiPjwvZm9udD48L3NwYW4+Jm5ic3A7PC9kaXY+CjxkaXY+PHNwYW4gY2xhc3M9IjM3MjM4Mjgx
Ni0wNDA4MjAwNiI+PGZvbnQgZmFjZT0iy87M5SIgc2l6ZT0iMiI+PC9mb250Pjwvc3Bhbj4mbmJz
cDs8L2Rpdj4KPGRpdj48c3BhbiBjbGFzcz0iMzcyMzgyODE2LTA0MDgyMDA2Ij48Zm9udCBmYWNl
PSLLzszlIiBzaXplPSIyIj5Nb2RpZnkgdGhlIGZzL2hvc3Rmcy9ob3N0ZnNfdXNlci5jIGZpbGUs
IHVwZGF0ZSB0aGUgcmVhZF9kaXIgZnVuY3Rpb24sPGJyPiZuYnNwOzwvZm9udD48L3NwYW4+PC9k
aXY+CjxkaXY+PHNwYW4gY2xhc3M9IjM3MjM4MjgxNi0wNDA4MjAwNiI+PGZvbnQgZmFjZT0iy87M
5SIgc2l6ZT0iMiI+Y2hhciAqcmVhZF9kaXIodm9pZCAqc3RyZWFtLCB1bnNpZ25lZCBsb25nIGxv
bmcgKnBvcyw8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHVuc2lnbmVkIGxvbmcgbG9u
ZyAqaW5vX291dCwgaW50ICpsZW5fb3V0KTxicj57PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBESVIgKmRpciA9IHN0cmVhbTs8YnI+Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHN0cnVjdCBkaXJlbnQgKmVudDsKPGJyPjxmb250
IGNvbG9yPSIjMDAwMGZmIj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgdW5zaWduZWQgbG9uZyBsb25nIG9sZHBvczs8L2ZvbnQ+PC9mb250Pjwvc3Bhbj48L2Rpdj4K
PGRpdj48Zm9udCBmYWNlPSLLzszlIiBjb2xvcj0iIzAwMDBmZiIgc2l6ZT0iMiI+PC9mb250PiZu
YnNwOzwvZGl2Pgo8ZGl2PjxzcGFuIGNsYXNzPSIzNzIzODI4MTYtMDQwODIwMDYiPjxmb250IGZh
Y2U9IsvOzOUiIGNvbG9yPSIjMDAwMGZmIiBzaXplPSIyIj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgb2xkcG9zID0gKnBvczs8L2ZvbnQ+PC9zcGFuPjwvZGl2Pgo8
ZGl2Pjxmb250IGZhY2U9IsvOzOUiIHNpemU9IjIiPjwvZm9udD4mbmJzcDs8L2Rpdj4KPGRpdj48
c3BhbiBjbGFzcz0iMzcyMzgyODE2LTA0MDgyMDA2Ij48Zm9udCBmYWNlPSLLzszlIiBzaXplPSIy
Ij4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc2Vla2RpcihkaXIs
ICpwb3MpOzxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZW50
ID0gcmVhZGRpcihkaXIpOzxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgaWYoZW50ID09IE5VTEwpPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyB7PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyByZXR1cm4o
TlVMTCk7PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9PGJy
PiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqbGVuX291dCA9IHN0
cmxlbihlbnQtJmd0O2RfbmFtZSk7Cjxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgKmlub19vdXQgPSBlbnQtJmd0O2RfaW5vOzxicj4mbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKnBvcyA9IHRlbGxkaXIoZGlyKTs8L2ZvbnQ+PC9z
cGFuPjwvZGl2Pgo8ZGl2Pjxmb250IGZhY2U9IsvOzOUiIHNpemU9IjIiPjwvZm9udD4mbmJzcDs8
L2Rpdj4KPGRpdj48c3BhbiBjbGFzcz0iMzcyMzgyODE2LTA0MDgyMDA2Ij48Zm9udCBmYWNlPSLL
zszlIiBjb2xvcj0iIzAwMDBmZiIgc2l6ZT0iMiI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IC8qIEZpeCB0aGUgdGVsbGRpciByZXR1cm4gMCBlcnJvciAqLzxicj4m
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKCpwb3MgPT0gMCk8
YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICpwb3MgPSBvbGRwb3MgKyAqbGVu
X291dDs8L2ZvbnQ+PC9zcGFuPjwvZGl2Pgo8ZGl2Pjxmb250IGZhY2U9IsvOzOUiIHNpemU9IjIi
PjwvZm9udD4mbmJzcDs8L2Rpdj4KPGRpdj48c3BhbiBjbGFzcz0iMzcyMzgyODE2LTA0MDgyMDA2
Ij48Zm9udCBmYWNlPSLLzszlIiBzaXplPSIyIj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgcmV0dXJuKGVudC0mZ3Q7ZF9uYW1lKTs8YnI+fTwvZm9udD48L3NwYW4+
PC9kaXY+CjxkaXY+PHNwYW4gY2xhc3M9IjM3MjM4MjgxNi0wNDA4MjAwNiI+PGZvbnQgZmFjZT0i
y87M5SIgc2l6ZT0iMiI+PC9mb250Pjwvc3Bhbj4mbmJzcDs8L2Rpdj4KPGRpdj48c3BhbiBjbGFz
cz0iMzcyMzgyODE2LTA0MDgyMDA2Ij48Zm9udCBmYWNlPSLLzszlIiBzaXplPSIyIj5hbHRob3Vn
aCB0aGUgbmV4dCBvZmZzZXQgaXMgbm90IGV4YWN0LCBidXQgdGhlIHJlYWRkaXIgY2FuIGdldCB0
aGUgbmV4dCBlbnRyeSBjb3JyZWN0LjwvZm9udD48L3NwYW4+PC9kaXY+CjxkaXY+PHNwYW4gY2xh
c3M9IjM3MjM4MjgxNi0wNDA4MjAwNiI+PGZvbnQgZmFjZT0iy87M5SIgc2l6ZT0iMiI+PC9mb250
Pjwvc3Bhbj4mbmJzcDs8L2Rpdj4KPGRpdj48c3BhbiBjbGFzcz0iMzcyMzgyODE2LTA0MDgyMDA2
Ij48Zm9udCBmYWNlPSLLzszlIiBzaXplPSIyIj5DYW4gYW55b25lIGdpdmUgYSBiZXR0ZXIgc29s
dXRpb24/PC9mb250Pjwvc3Bhbj48L2Rpdj4KPGRpdj48c3BhbiBjbGFzcz0iMzcyMzgyODE2LTA0
MDgyMDA2Ij48Zm9udCBmYWNlPSLLzszlIiBzaXplPSIyIj48L2ZvbnQ+PC9zcGFuPiZuYnNwOzwv
ZGl2Pgo8ZGl2PjxzcGFuIGNsYXNzPSIzNzIzODI4MTYtMDQwODIwMDYiPjwvc3Bhbj4mbmJzcDs8
L2Rpdj4KPGRpdj48c3BhbiBjbGFzcz0iMzcyMzgyODE2LTA0MDgyMDA2Ij48Zm9udCBmYWNlPSLL
zszlIiBzaXplPSIyIj48L2ZvbnQ+PC9zcGFuPiZuYnNwOzwvZGl2Pgo=
------=_Part_82190_30527524.1155224534229--


--===============0403300631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0403300631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0403300631==--
