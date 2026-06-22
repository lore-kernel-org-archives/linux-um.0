Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF77CD98F2
	for <linux-um@archiver.kernel.org>; Mon, 22 Jun 2026 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AqRTg9jOX9Gjt6m176ot31Vs2qjsZUYGYEsU/aFytIM=; b=kAzfzaZxYKp2c8yttWtrILSe8v
	qNCvUNokuMx0Nb5Jq6IhD+E95d1q4Y8AhUZkucQM1hf01OSMDWY0JytFrpQ6vjrutGp4Tw67vPvMc
	Wf8dO4Xh7YcXM3YvJIyiKjnBGDodSM+ZX6eLLoQ82WYJraOD0GjA+RCnbM5h0P7TiF0bpW1DFqn3c
	FdLedexiFIXdl+YCEZ7+mx6/n/ujpZJBepff2zDuFxRHtS2J4Rq7AabwN7h7RFzYK7wWGDCdwELby
	bormsqcJFKfwoL607ocha73cFHttXrLGJe+mQRBkJtVNuQrxATcETPv1hBV9K9ScS+1ZTgOA6ohev
	MMMml3Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbe4l-00000004ypD-2K0B;
	Mon, 22 Jun 2026 12:48:31 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbe4i-00000004yo5-416X
	for linux-um@lists.infradead.org;
	Mon, 22 Jun 2026 12:48:30 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-8dcd895a4c0so53076336d6.3
        for <linux-um@lists.infradead.org>; Mon, 22 Jun 2026 05:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782132507; x=1782737307; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AqRTg9jOX9Gjt6m176ot31Vs2qjsZUYGYEsU/aFytIM=;
        b=VXc2559GV8Tbv5y+FoZlULLDI+BN2OmWr22NKuUvmy+xJt7OJHWBXMhv/7IAnOgn5/
         NPjOI+i127jKgs4cDKLZJ4aaVzXgUmXp5M5lwTWJFYyTF0l8rncZllQj1HeaiHBCw1Vf
         uW+wcjUuQb15Uw/RK8PDEX43RQpSU88XnkfTCfeGogBvQKOAk6JSnKDiqBVEVFsRH5g6
         RyXfRNXbEC5JSzQyFn3f9oz34zLojRAgz5g+XQyUuFfcZUhzFIYamWod56Dj7QZpsXHp
         z0msZyWUHjTUXEedIu4Aj74UorRwtZ93enfoJEVZpY8pIrT5OV9dJxusctjN4XhN2bwn
         3oWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782132507; x=1782737307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqRTg9jOX9Gjt6m176ot31Vs2qjsZUYGYEsU/aFytIM=;
        b=i1JEVIzWnZBESAsk/Cfb1X8FhAB0UCj6Psl+PVuEDjjsgQx1p0mtDyOzq/DfsGWt0S
         HCdRbfAH0MTbMLMrwWp0SlzE7je6+/9l/J9H08/Y4Y2YqL71mnSk2JcCjylAUkKDOQh7
         B6+zpQByzVlviMjT6Nf2E+Xx4qGSs4DIEO9w4oBZ0HLUpp89tJQ42dHKrYfHcqnZk8j5
         X1wj7XcTFvX8gt6XeU9+anvk1FgVjJylcjz3uq0QaaHqe5bOSlBJpAGZ47azY0ut2o9B
         C+/xfiUKNwO6hCeK58BugAmHYzQ0rJfY1la3RgSWPlznhHMXtgEtonG/GBSaz812rqVL
         8uKg==
X-Gm-Message-State: AOJu0YySEA7FVnVqRxa5tRyJbgrMp6sn1UtbOusCJpn8igOQt3hYkYXo
	EmleFfScJy143pmIDqAQmjka4ODqc1ZpbT4/3S4uV1xBqpFdcNOUVP166GDxDy2H
X-Gm-Gg: AfdE7clsTK5iVXpluUm34g6lWs5nZ7gmkGQPn1pnQ1Dwx6QungAwyYYgw4yCCKHaqJb
	FdLCdHRgcdU+GRMcWY3B9G/ndOBPU5szrc0Y8qOQ7mJ659kf84XLOjE3JAsY7rwC7vCWkeNFeEW
	PTw7hs2swrmQVcxeYMc4eJOVLMABwrmuFeuuz/AZ1WNp2XNaCVXRCl1clNGGgdYsmBsOC9+/Hjx
	pi5FddcmrOKgbGnzX99SjUhgSgTsZegZr3gvLnoBx6fgQ7JiIge9Kb6M8q97DsjDdWuuIS/mrlt
	x7mNXCTHDeFQJ8vuqZ45eT4djgBEhDJ52DTzazZ0y+AhYcriG9v3p+IZKEYNShk9PKtjzDAcgDm
	7RKZazm8FOw4+82o+d6ZliakmirdMHHdRKWsKH60GIi8WfoAym+Sbsj4rrWrwRgPneWFagbTPZw
	ptOFDGGqf39ADJlokTfxRL0PaGCasCgNELJsMZ3vGj4OSiU/dpMSIgKGGrc9LXcsyHhcnVoEDAC
	a5NYZsY2eAcpl7u7n2RXdeEkCA+JVWq
X-Received: by 2002:a05:6214:500b:b0:8d2:f76d:690c with SMTP id 6a1803df08f44-8de419b4057mr268057586d6.29.1782132507535;
        Mon, 22 Jun 2026 05:48:27 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82692bddsm93099486d6.43.2026.06.22.05.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:48:26 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: ubd: validate COW header fields before use
Date: Mon, 22 Jun 2026 08:48:23 -0400
Message-ID: <20260622124823.1695944-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_054829_019519_5ACD3867 
X-CRM114-Status: GOOD (  16.99  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

read_cow_header() copies the backing-file path and computes geometry
from header fields without validating them, and the historical
"XXX Need to sanity-check the values read from the header" comment was
never addressed. Three image-controlled fields are unsafe:

  - backing_file[]: not guaranteed NUL-terminated. cow_strdup() and the
    later strlen()/printf() walk off the end of the header buffer when a
    crafted image leaves the array unterminated (heap over-read).

  - sectorsize: used as a divisor in cow_sizes()
    (bitmap_len = (size + sectorsize - 1) / (8 * sectorsize)); a zero or
    negative sectorsize causes a divide-by-zero / bogus geometry.

  - For the V3/V3_b layouts the existing "align == 0" check printed a
    warning but fell through and then computed
    ROUND_UP(sizeof(header), 0), another divide-by-zero.

Reject an unterminated backing_file for each header version, turn the
align == 0 warnings into hard errors (goto out), and reject a
non-positive sectorsize before the geometry math runs.

A COW image is parsed from a file the guest opens (ubdN=cow,backing on
the command line, or a cow file an unprivileged user can point ubd at),
so a crafted header is attacker-reachable.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Reproduced on a UML KASAN build (ARCH=um) off this base, driving ubd with
crafted COW images. Stock: an unterminated v2 backing_file over-reads the
header buffer (KASAN slab-out-of-bounds read in the strdup/strlen path); a
sectorsize=0 image and a v3 alignment=0 image each hit a divide error in
the cow_sizes()/ROUND_UP geometry. Patched: each crafted image is rejected
in read_cow_header() ('not terminated' / 'invalid sectorsize' / 'align ==
0') and the driver continues. Benign control: a valid COW image opens
cleanly on both stock and patched. Before/after logs available on request.

 arch/um/drivers/cow_user.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index dc1d1bcd85ec2..bb9f05ac70cf4 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -279,7 +279,7 @@ int file_reader(__u64 offset, char *buf, int len, void *arg)
 	return pread(fd, buf, len, offset);
 }
 
-/* XXX Need to sanity-check the values read from the header */
+/* Sanity checks are performed after reading each header version below. */
 
 int read_cow_header(int (*reader)(__u64, char *, int, void *), void *arg,
 		    __u32 *version_out, char **backing_file_out,
@@ -325,6 +325,12 @@ int read_cow_header(int (*reader)(__u64, char *, int, void *), void *arg,
 		*sectorsize_out = header->v1.sectorsize;
 		*bitmap_offset_out = sizeof(header->v1);
 		*align_out = *sectorsize_out;
+		if (!memchr(header->v1.backing_file, '\0',
+			    sizeof(header->v1.backing_file))) {
+			cow_printf("%s - V1 backing_file not terminated\n",
+				   __func__);
+			goto out;
+		}
 		file = header->v1.backing_file;
 	}
 	else if (version == 2) {
@@ -338,6 +344,12 @@ int read_cow_header(int (*reader)(__u64, char *, int, void *), void *arg,
 		*sectorsize_out = be32toh(header->v2.sectorsize);
 		*bitmap_offset_out = sizeof(header->v2);
 		*align_out = *sectorsize_out;
+		if (!memchr(header->v2.backing_file, '\0',
+			    sizeof(header->v2.backing_file))) {
+			cow_printf("%s - V2 backing_file not terminated\n",
+				   __func__);
+			goto out;
+		}
 		file = header->v2.backing_file;
 	}
 	/* This is very subtle - see above at union cow_header definition */
@@ -354,8 +366,15 @@ int read_cow_header(int (*reader)(__u64, char *, int, void *), void *arg,
 		if (*align_out == 0) {
 			cow_printf("read_cow_header - invalid COW header, "
 				   "align == 0\n");
+			goto out;
 		}
 		*bitmap_offset_out = ROUND_UP(sizeof(header->v3), *align_out);
+		if (!memchr(header->v3.backing_file, '\0',
+			    sizeof(header->v3.backing_file))) {
+			cow_printf("%s - V3 backing_file not terminated\n",
+				   __func__);
+			goto out;
+		}
 		file = header->v3.backing_file;
 	}
 	else if (version == 3) {
@@ -385,14 +404,27 @@ int read_cow_header(int (*reader)(__u64, char *, int, void *), void *arg,
 		if (*align_out == 0) {
 			cow_printf("read_cow_header - invalid COW header, "
 				   "align == 0\n");
+			goto out;
 		}
 		*bitmap_offset_out = ROUND_UP(sizeof(header->v3_b), *align_out);
+		if (!memchr(header->v3_b.backing_file, '\0',
+			    sizeof(header->v3_b.backing_file))) {
+			cow_printf("%s - V3 backing_file not terminated\n",
+				   __func__);
+			goto out;
+		}
 		file = header->v3_b.backing_file;
 	}
 	else {
 		cow_printf("read_cow_header - invalid COW version\n");
 		goto out;
 	}
+
+	if (*sectorsize_out <= 0) {
+		cow_printf("%s - invalid sectorsize %d\n", __func__,
+			   *sectorsize_out);
+		goto out;
+	}
 	err = -ENOMEM;
 	*backing_file_out = cow_strdup(file);
 	if (*backing_file_out == NULL) {

base-commit: ef0c9f75a19532d7675384708fc8621e10850104
-- 
2.53.0


