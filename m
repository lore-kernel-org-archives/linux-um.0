Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1A4C982C1
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 22:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=NyzJKtlzkr5VmC
	J1YiPTry3bfcmQ0ZUXRBoiNDNkquEYTXi8a2uHAIoFgM2suGk30vWFzHTdjvblR+6AAk4utuT6/Bw
	7cTzFEsYvo7F1qKiKgG5h1+EDSDlohx3XkbaeCsOdPXAtoWs1Eg9SHTiFWXkxcx8PBIK5rBtOMWvA
	DBjXb5wPEV4v9P0sR45bXu9GEFsDaOjvmKSrG9+sfdfAhuUSUW8JTkzU/hrq9/ijtcfFi2EQTmiVg
	g9rOcYkVe2pqsIe1lrUDzUq8/xHNqvx+7yHKflzmZGD4t5RAGAZq7oK8kk9cFpSDux15CKTxcfVZI
	4uUObPNAAca8aewyl/Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6bWz-0000000802y-0ArH;
	Tue, 15 Sep 2026 22:21:37 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6bWv-0000000801s-2P24
	for linux-um@lists.infradead.org;
	Tue, 15 Sep 2026 22:21:34 +0000
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLYnKN619815
	for <linux-um@lists.infradead.org>; Tue, 15 Sep 2026 22:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=IV
	/k2TQjkUrsTGpshqW8f1AkLpzgE6WqJLnJXyVNHKYz8mozA+vLQbIOpShvI99Nvk
	BGk11nj45xZQZMebNdo7NiYw/EO7W5wcvHVc8eAkRKtGrNMclkKkbe3unomYvdUd
	vFaT1byqggr1zubtRjDzuTG9pECEQdOzFAiv4kdIU3d7CXM0IsQ27dhrP8NvQBkU
	TlOdMgPnM8h4FF25SXM2n03VFD94RLvjnLlaGSHHxie20ptztZeSDX3B4EelrzMT
	n1DLEJiB1mKEp0dVH3Si7JCiMZpC8ZcIigaByfbQDV2F2ANWVcL1rru5kNRyAlZ9
	ag1DWjYpUlLQQuGalXdA==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq2y2kj72-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-um@lists.infradead.org>; Tue, 15 Sep 2026 22:21:31 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-46509ab0149so6391316fac.2
        for <linux-um@lists.infradead.org>; Tue, 15 Sep 2026 15:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789510891; cv=none;
        d=google.com; s=arc-20260327;
        b=IwqL83EB2hlAKibqs7HYWgosyBBbht2ldM+EORNaU1nzK1hd0WzV0IGN6iXxgnpf64
         QVJq6pN6KC63HNFTeoKkW3+ytpm1F0Qmj9r0TIf2H/H3ukVt/PmhTIwRxUdOlnZ/GnHu
         wkugNuqA/2P06sUateQwjtUI5ouAJJdI3Tv5eBvyazmpXVBVFDluwy3+l/BrWeOOhGx+
         kYSrrQrlZnUS3JsGI+YKA561LINgtdpBEBl5H5jrI0OLcfivut+DeSUfmDIcTQhFVHeq
         /6SGapZ0RwwfK5deSRMa296rNUhjgF+4AAwmlABHZOO2tP6RgFqWdzpMfIKtx+APonRj
         cweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        fh=lql8zuHl9UIkjSLnxKqqkxSbTkhyfF59LjAmiOtrIvY=;
        b=C+EHYjToDQMbPxp5F/kEkQN1y53vLz8cK6BIR9KXGyopLdpslouaGizk8IAVVfY+tb
         7Lz2Zrzz8lrceA6ClRxrvLNPiSbY6dq/4Vaf/k+9SHvDuVni0lbUw8zWPJkH4Yn0YfQ0
         XvAXs9E3EzPV4MlcLzkd4bOWh5wsaIgk4m2jvL1or4f7Zni6AOEB87L6TBi6YEWvzS3x
         DpRXWzuLGelgtE+Hhvha73aPI5s/pGFjhfNhSKchk6H3WQJEElwyAlZozVDqY04BCMJS
         5VlG+JRbymziwauBdyeZiIm5jI5dCCRVD+vLVVF2JJN8BtAYjqScBFFeBMMhmXa48Ca5
         nOAw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789510891; x=1790115691; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=FoTYuFy9GrqqNPcs1ZFGImcDmRL5AF9tq00ISMZkXgyjMZso2cbXZu+IbhHuJEU0BS
         VWv/pOAett/QhTdHkSetFnVbD/ogWtyJKXz5277/WTmhKGdLtFY0HcChI704vPTlMNDr
         02xytw1UeSFN0BKquJSAR4ejrsJUyRfI4KIqytyIdzxV1H8h8VtTx9mlIZrOslCPyzj4
         vjeAgEZdkOzDEdReEGEYOZn+0ldFnOsa2SZdaNXUzMaTX9OjXgy8c1NLh6Jvs0vojiuC
         g+pWBU5OW7qvWZoeP0CfWock+ACnTw0fy4IMEsaT9qYGaG1p7uUXs4dgoI3E5AiBuPoh
         r50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510891; x=1790115691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=ZnqTg2cs6ew2MNPPEethAF4Q41j5sDQkHZjX8MdBDTQZUsAd9jQhvLYw4Ng2XW6JiJ
         PN5/IKrGUrMQmYckKfJ0nQqEMCtWVHw203g7bx5O/A5GSifoein1CKKolx2ATTF/3hnD
         WcnBs45+reUbslNc/6FgBq8ik/uXiJ2mUSpjsuVU+8b4q3PtBuGRXWoPI0cR/jGRaZUb
         hIIfhNWKfth+Ey8q2q+GUfv1Mb0fXxmP+RXDAP+FswEPopJrrJ+0lJdWYVUxAJiyXOyg
         kreapgxkwIzDrevOnk8Q5oh28T/z5DdPY2CNI3o0vdG+pqj0JJAXW1Mx9MJDkRzftfFg
         e2FA==
X-Forwarded-Encrypted: i=1; AKwUvBz29wxNoJx8yV/ggV5zLt3t7zbjAE4OR/dNelCJgpv6rKoRlPXxbf121Gx/KkLKSRJDAKfCKOt2HQ==@lists.infradead.org
X-Gm-Message-State: AFuF++lE1u0dPlHL6qK22D9YM7wUg/kxDtLXyb0LrpZQIjDliaxvezyC
	My3cjjCG46i/aB+QMZWG/1nHtW32w7kp6cCPjzCUODUyb1NslNy+mp1fNy3jmZL72KVSklF50Lf
	wIvc6U2j/SOHCgA97w3x/AWswRpCk1uAxGvyxHLqgmOB+cu9zpAwpQk0V+dm9UcHIPnC8ORmHj6
	VBIxNzu+caUtozzUnad4FYL4r4vrqyKpXX4RpsgTb0OQ==
X-Gm-Gg: AYBFou0mU3II9Ydzt85W7R41WD9TcBM7wvwM/AMuHLhLqMeKBZSe0/gKCkGhxoWkS2O
	u3Hu6slnsqJD7YbfMHFsKtwddzOlbywXpQ7HbWjyFa+fl8ymVBUCUnG6rKKKvnMIe9UiLo4qDmb
	umVe3v4vsH4MVqbFK019hzHRs47IINdWu5sZE9FmC+ZYfUU/CPmF/F4Y8R
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id 586e51a60fabf-4847584c51dmr189779fac.2.1789510890870;
        Tue, 15 Sep 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-4847584c51dmr189724fac.2.1789510890430; Tue, 15 Sep 2026
 15:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 15:21:18 -0700
X-Gm-Features: AcwNN1UxxSxAxz0XPK7niSod0Tx_HsUs-C3mKdcqDSaFkh659BGkCorPygYZGHE
Message-ID: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
        David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: IK_f5P6f-8xJjf7Cjhkcih_e8FknUlvG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX3U7uzKy9gGN6
 jTzmYn4w187i1AZmqEaJKbQfnyFccWJG1kVmAyucZfD5mNyhAUqWSNu6/GoObtQiTdvLlWLSUOg
 KEQSJDOUe8lUmmmdm7VfcLdLPSmSWrwZ1uIxfyzcqhzUd62RrYX9rAJQyYc+8EAGTQp9cWQS8d4
 7xzWdYYLF/anfFrusepSFmEQ78aNCrQcwrd8OjgJZL4SaNYiFAoae/8cxbh6eVdznRQ4bL3ZvRQ
 HkS/CGksN+wxzJgwjWg3IpCLoQY28QITzwUIeYb0auxITa1Fq9Oz6WHBDSvT5waPOprNMDBJ+cV
 8OmPskRGt4umvoLMVpoqal/t57jFnOix8BKotmNiZ1E75WmKNPgcrzLdDXoVztCQm2eUIpFCSzP
 lnzK0OSs8bRPtu8heXNczGsJAhcC4Zbik7LmWUQXyTetvdAn/Z4TJxaR6aI9xzDCFC8M9fbnp5Z
 pu+qFhPueaQr2pWdixg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfXw5p90ouz7AMd
 P3A1Rt7S5xru5ENAlm3bZM/itoRIJ3dWLmmO1YXLa1Riw/4SGIntzQoKzSSYKn8JhR0UQnJC5xn
 dR2HP7Moj3gRUuGUizXUpgTfFzF2/7M=
X-Proofpoint-GUID: IK_f5P6f-8xJjf7Cjhkcih_e8FknUlvG
X-Authority-Analysis: v=2.4 cv=IcISymqa c=1 sm=1 tr=0 ts=6aa9c4eb cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=2Rxv5svHm-zNKBYa0PsA:9 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150326
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_152133_744429_6F695939 
X-CRM114-Status: GOOD (  19.72  )
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, Sep 15, 2026 at 9:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wro=
te:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it i=
n
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
>
> Honestly, I am *not* a fan. At all.
>
> I think this adds complexity rather than removing it.
>
> The diffstat tells a story:
>
> >  106 files changed, 962 insertions(+), 861 deletions(-)
>
> in how this adds a hundred lines more than it deletes.
>
> But to make things worse, it adds them in bad places: low-level
> architecture assembly code.
>
> Those extra lines are *not* making complicated code simpler. Quite the
> reverse. They are taking fairly straightforward "just deal with errors
> with normal cleanup in the place where it makes sense" and makes the
> *straightforward* case simpler, while making the big picture more
> complicated and subtle, and adding new code to places that are not
> simple and just blindly do somethign that makes no sense in that
> context.

With fd's it is more than just about error rollback.. exposing an fd
to userspace mid-way thru an ioctl is an easy security bug to write..

OTOH, "just use FD_PREPARE() / fd_publish()"..

BR,
-R

