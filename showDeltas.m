function showDeltas(rhos, deltas)%���ݵ�ľֲ��ܶ����飬���ݵ�ľ��루����Լ��ܶȴ�ĵ�ľ������Сֵ������
%     subplot(2,2,2);
    tt = plot(rhos(:), deltas(:), 'o', 'MarkerSize', 3, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');
%     text = strcat('max rho: ', num2str(max(rhos)), ', delta: ', num2str(max(deltas)));
%     title (text, 'FontSize', 15.0);
%�����ܶ�-�����άͼ
    xlabel ('\it \rho');
    ylabel ('\it \delta');
end